module my_addrx::JobReferralPlatform {
    use std::coin::{transfer};
    use std::aptos_coin::AptosCoin;
    use std::signer;
    use std::vector;
    use std::string::String;

    const ERR_JOB_NOT_FOUND: u64 = 1;
    const ERR_UNAUTHORIZED: u64 = 2;
    const ERR_REFERRAL_NOT_FOUND: u64 = 3;
    const ERR_ALREADY_HIRED: u64 = 4;
    const ERR_NO_ACTIVE_JOBS: u64 = 5;
    const ERR_ALREADY_INITIALIZED: u64 = 6;

    const Global_Job_List: address = @sys_addrx;

    // Struct representing a job listing
    struct Job has key, store, copy, drop {
        id: u64,
        employer: address,  // Employer's address
        title: String,  // Job title
        description: String,  // Job description
        finders_fee: u64,  // Finder's fee amount (APT tokens)
        is_filled: bool,  // Whether the job is filled or not
        referrals: vector<Referral>,  // List of referrals for the job
    }

    // Struct representing a referral for a job
    struct Referral has key, store, copy, drop {
        referrer: address,  // Referrer's address
        candidate: address,  // Candidate's address
        referral_message: String,  // Message from referrer
        is_hired: bool  // Whether the candidate was hired
    }

    // Global struct representing the collection of job listings
    struct GlobalJobCollection has key, store, copy, drop {
        jobs: vector<Job>,
        last_job_id: u64,  // Tracks the last used job ID
    }

    // Initialize the global job platform (only called once)
    public entry fun init_job_platform(account: &signer) {
        let global_address = Global_Job_List;

        if (exists<GlobalJobCollection>(global_address)) {
            abort(ERR_ALREADY_INITIALIZED)
        };

        let job_collection = GlobalJobCollection {
            jobs: vector::empty<Job>(),
            last_job_id: 1000,
        };

        move_to(account, job_collection);
    }

    // Employer creates a new job listing
    public entry fun create_job(
        account: &signer,
        title: String,
        description: String,
        finders_fee: u64
    ) acquires GlobalJobCollection {
        let employer_address = signer::address_of(account);
        let global_address = Global_Job_List;

        assert!(exists<GlobalJobCollection>(global_address), ERR_NO_ACTIVE_JOBS);

        let collection_ref = borrow_global_mut<GlobalJobCollection>(global_address);

        let job_id = collection_ref.last_job_id + 1;
        let new_job = Job {
            id: job_id,
            employer: employer_address,
            title: title,
            description: description,
            finders_fee: finders_fee,
            is_filled: false,
            referrals: vector::empty<Referral>(),
        };

        // Add the new job to the job list
        vector::push_back(&mut collection_ref.jobs, new_job);
        collection_ref.last_job_id = job_id;
    }

    // Anyone can refer a candidate for a job
    public entry fun refer_candidate(
        account: &signer,
        job_id: u64,
        candidate: address,
        referral_message: String
    ) acquires GlobalJobCollection {
        let referrer_address = signer::address_of(account);
        let global_address = Global_Job_List;

        assert!(exists<GlobalJobCollection>(global_address), ERR_NO_ACTIVE_JOBS);

        let collection_ref = borrow_global_mut<GlobalJobCollection>(global_address);
        let jobs_len = vector::length(&collection_ref.jobs);
        let i = 0;

        while (i < jobs_len) {
            let job_ref = vector::borrow_mut(&mut collection_ref.jobs, i);
            if (job_ref.id == job_id) {
                // Ensure the job isn't filled
                assert!(!job_ref.is_filled, ERR_ALREADY_HIRED);

                // Create the referral and add it to the job's referral list
                let new_referral = Referral {
                    referrer: referrer_address,
                    candidate: candidate,
                    referral_message: referral_message,
                    is_hired: false,
                };

                vector::push_back(&mut job_ref.referrals, new_referral);
                return
            };
            i = i + 1;
        };
        abort(ERR_JOB_NOT_FOUND)
    }

    // Employer confirms a hire and releases the finder's fee
    public entry fun confirm_hire(
        account: &signer,
        job_id: u64,
        candidate: address
    ) acquires GlobalJobCollection {
        let employer_address = signer::address_of(account);
        let global_address = Global_Job_List;

        assert!(exists<GlobalJobCollection>(global_address), ERR_NO_ACTIVE_JOBS);

        let collection_ref = borrow_global_mut<GlobalJobCollection>(global_address);
        let jobs_len = vector::length(&collection_ref.jobs);
        let i = 0;

        while (i < jobs_len) {
            let job_ref = vector::borrow_mut(&mut collection_ref.jobs, i);
            if (job_ref.id == job_id) {
                // Ensure that the caller is the employer
                assert!(job_ref.employer == employer_address, ERR_UNAUTHORIZED);

                // Ensure the job isn't already filled
                assert!(!job_ref.is_filled, ERR_ALREADY_HIRED);

                // Search for the referral with the matching candidate
                let referrals_len = vector::length(&job_ref.referrals);
                let j = 0;

                while (j < referrals_len) {
                    let referral_ref = vector::borrow_mut(&mut job_ref.referrals, j);
                    if (referral_ref.candidate == candidate) {
                        // Confirm hire
                        referral_ref.is_hired = true;
                        job_ref.is_filled = true;

                        // Pay the finder's fee to the referrer
                        transfer<AptosCoin>(account, referral_ref.referrer, job_ref.finders_fee);
                        return
                    };
                    j = j + 1;
                };
                abort(ERR_REFERRAL_NOT_FOUND)
            };
            i = i + 1;
        };
        abort(ERR_JOB_NOT_FOUND)
    }

    // View all job listings
    #[view]
    public fun view_all_jobs(): vector<Job> acquires GlobalJobCollection {
        let global_address = Global_Job_List;
        assert!(exists<GlobalJobCollection>(global_address), ERR_NO_ACTIVE_JOBS);

        let collection_ref = borrow_global<GlobalJobCollection>(global_address);
        collection_ref.jobs
    }

    // View job details by job ID
    #[view]
    public fun view_job_by_id(job_id: u64): Job acquires GlobalJobCollection {
        let global_address = Global_Job_List;
        assert!(exists<GlobalJobCollection>(global_address), ERR_NO_ACTIVE_JOBS);

        let collection_ref = borrow_global<GlobalJobCollection>(global_address);
        let jobs_len = vector::length(&collection_ref.jobs);
        let i = 0;

        while (i < jobs_len) {
            let job_ref = vector::borrow(&collection_ref.jobs, i);
            if (job_ref.id == job_id) {
                return *job_ref
            };
            i = i + 1;
        };
        abort(ERR_JOB_NOT_FOUND)
    }

    // View referrals for a specific job
    #[view]
    public fun view_referrals(job_id: u64): vector<Referral> acquires GlobalJobCollection {
        let global_address = Global_Job_List;
        assert!(exists<GlobalJobCollection>(global_address), ERR_NO_ACTIVE_JOBS);

        let collection_ref = borrow_global<GlobalJobCollection>(global_address);
        let jobs_len = vector::length(&collection_ref.jobs);
        let i = 0;

        while (i < jobs_len) {
            let job_ref = vector::borrow(&collection_ref.jobs, i);
            if (job_ref.id == job_id) {
                return job_ref.referrals
            };
            i = i + 1;
        };
        abort(ERR_JOB_NOT_FOUND)
    }

    // View all jobs created by a specific employer
    #[view]
    public fun view_jobs_by_employer(employer: address): vector<Job> acquires GlobalJobCollection {
        let global_address = Global_Job_List;
        assert!(exists<GlobalJobCollection>(global_address), ERR_NO_ACTIVE_JOBS);

        let collection_ref = borrow_global<GlobalJobCollection>(global_address);
        let result = vector::empty<Job>();

        let jobs_len = vector::length(&collection_ref.jobs);
        let i = 0;

        while (i < jobs_len) {
            let job_ref = vector::borrow(&collection_ref.jobs, i);
            if (job_ref.employer == employer) {
                vector::push_back(&mut result, *job_ref);
            };
            i = i + 1;
        };
        result
    }

    // View all referrals done by a specific address
    #[view]
    public fun view_referrals_by_referrer(referrer: address): vector<Referral> acquires GlobalJobCollection {
        let global_address = Global_Job_List;
        assert!(exists<GlobalJobCollection>(global_address), ERR_NO_ACTIVE_JOBS);

        let collection_ref = borrow_global<GlobalJobCollection>(global_address);
        let result = vector::empty<Referral>();

        let jobs_len = vector::length(&collection_ref.jobs);
        let i = 0;

        while (i < jobs_len) {
            let job_ref = vector::borrow(&collection_ref.jobs, i);
            let referrals_len = vector::length(&job_ref.referrals);
            let j = 0;

            while (j < referrals_len) {
                let referral_ref = vector::borrow(&job_ref.referrals, j);
                if (referral_ref.referrer == referrer) {
                    vector::push_back(&mut result, *referral_ref);
                };
                j = j + 1;
            };
            i = i + 1;
        };
        result
    }
}
