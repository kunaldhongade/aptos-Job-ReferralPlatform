# JobReferralPlatform Smart Contract

The `JobReferralPlatform` smart contract provides a decentralized platform where employers can post jobs and users can refer candidates. Referrers are rewarded with a finder’s fee upon a successful hire. The contract is built on the Aptos blockchain, ensuring transparent and secure job referrals and payments.

## Features:

- Employers can create job listings with a defined finder’s fee.
- Users can refer candidates for jobs with referral messages.
- Employers can confirm a hire, releasing the finder’s fee to the referrer.
- View all jobs, job details, referrals, and job history by employer or referrer.

---

## Module: `my_addrx::JobReferralPlatform`

### Dependencies:

- **std::coin::transfer**: To transfer AptosCoin as payment for referrals.
- **aptos_coin::AptosCoin**: Used for finder's fees in Aptos tokens.
- **signer**: To authorize actions by employers and referrers.
- **vector**: For managing lists of jobs and referrals.
- **string::String**: To store job and referral descriptions.

### Constants:

- **Error Codes**:

  - `ERR_JOB_NOT_FOUND`: Job does not exist.
  - `ERR_UNAUTHORIZED`: Unauthorized access.
  - `ERR_REFERRAL_NOT_FOUND`: Referral does not exist.
  - `ERR_ALREADY_HIRED`: The job has already been filled.
  - `ERR_NO_ACTIVE_JOBS`: No active jobs available.
  - `ERR_ALREADY_INITIALIZED`: The platform is already initialized.

- **Global Job List Address**:
  - A global address (`Global_Job_List`) stores all job listings.

---

## Structs:

1. **`Job`**:

   - Represents a job listing with the following fields:
     - `id`: Unique ID for the job.
     - `employer`: The address of the employer.
     - `title`: Job title.
     - `description`: Job description.
     - `finders_fee`: The amount of Aptos tokens as a finder’s fee.
     - `is_filled`: Whether the job is filled.
     - `referrals`: List of referrals for the job.

2. **`Referral`**:

   - Represents a referral made by a user with these fields:
     - `referrer`: Address of the referrer.
     - `candidate`: Address of the referred candidate.
     - `referral_message`: Custom message accompanying the referral.
     - `is_hired`: Indicates whether the candidate was hired.

3. **`GlobalJobCollection`**:
   - Stores all jobs and tracks the last job ID.
     - `jobs`: List of all job postings.
     - `last_job_id`: Tracks the ID of the most recently added job.

---

## Public Entry Functions:

### 1. **`init_job_platform(account: &signer)`**:

Initializes the platform by creating the `GlobalJobCollection` at the global address. Only called once.

### 2. **`create_job(account: &signer, title: String, description: String, finders_fee: u64)`**:

Allows an employer to create a new job listing. The job is added to the global collection with the specified title, description, and finder's fee.

### 3. **`refer_candidate(account: &signer, job_id: u64, candidate: address, referral_message: String)`**:

Allows users to refer a candidate for an open job. The referral is attached to the job listing, and a message can be included by the referrer.

### 4. **`confirm_hire(account: &signer, job_id: u64, candidate: address)`**:

Allows the employer to confirm a hire for a candidate. Upon confirmation, the referrer receives the finder’s fee, and the job is marked as filled.

---

## View Functions:

### 1. **`view_all_jobs()`**:

Returns a list of all job listings.

### 2. **`view_job_by_id(job_id: u64)`**:

Returns details of a specific job by job ID.

### 3. **`view_referrals(job_id: u64)`**:

Returns a list of all referrals for a specific job.

### 4. **`view_jobs_by_employer(employer: address)`**:

Lists all jobs created by a specific employer.

### 5. **`view_referrals_by_referrer(referrer: address)`**:

Lists all referrals made by a specific referrer.

---

## Frontend Integration

### Functionalities:

- **Create Job**: Employers can create job listings by specifying job details such as title, description, and finder’s fee.
- **Refer Candidate**: Users can refer candidates for jobs by providing the candidate’s address and a referral message.
- **Confirm Hire**: Employers can confirm a successful hire, releasing the finder’s fee to the referrer.
- **View Jobs**: Users can view available jobs and referrals.

### Tools and Libraries:

- **React (JavaScript/TypeScript)**: For building the frontend UI.
- **Aptos SDK**: To interact with the smart contract on the blockchain.
- **Tailwind CSS**: For responsive styling of the frontend.
- **Ant Design**: UI components for forms, buttons, and job listings.

---

## Sample Workflow:

1. **Employer**: Creates a job listing.
2. **Referrer**: Refers a candidate for the job.
3. **Employer**: Confirms the hire of the referred candidate, releasing the finder’s fee to the referrer.

---

## Deployment Steps:

1. **Clone the repository**.
2. **Install dependencies**: Run `npm install` or `yarn install` to set up the frontend.
3. **Start the frontend**: Run `npm run dev` or `yarn run dev` to launch the development server.
4. **Deploy the contract**: Use the Aptos testnet for deployment and interaction with the contract.
