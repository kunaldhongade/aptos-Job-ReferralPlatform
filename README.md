# 🚀 JobReferralPlatform - Frontend

Welcome to the **JobReferralPlatform** frontend, a decentralized application built on the **Aptos Blockchain**. This platform allows **employers** to post job listings and manage referrals, while **users** can refer candidates and earn finder’s fees upon successful hires. All transactions and job referrals are handled securely through smart contracts on the blockchain.

---

## 🔗 Links

- **Live Demo**: [JobReferralPlatform](https://aptos-job-referral-platform.vercel.app/)
- **Smart Contract Explorer**: [Aptos Explorer](https://explorer.aptoslabs.com/account/0x2abb1ab290cb828323bf6da71a3f36011d59cd7aa576474f19dbcae50521e056/modules/code/JobReferralPlatform?network=testnet)

---

## ✨ Key Features

- **Browse Jobs**: Users can view and explore available job postings with details like descriptions, finder’s fees, and deadlines.
- **Refer Candidates**: Users can refer candidates for jobs, providing custom referral messages.
- **Confirm Hires**: Employers can confirm hires and automatically trigger finder’s fees to referrers.
- **Manage Jobs and Referrals**: Employers can view posted jobs, track referrals, and confirm candidates.
- **Secure Transactions**: Payments and job operations are managed on-chain using Aptos smart contracts, ensuring transparency and security.

---

## 📋 Prerequisites

Ensure the following are installed:

- **Node.js**: v16 or higher
- **npm** or **yarn**
- **Aptos Wallet** (e.g., **Petra Wallet**) to interact with the platform

---

## ⚙️ Setup Instructions

### 1. Clone the Repository

```bash
cd job-referral-platform
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Configure Environment Variables

Create a `.env` file in the root directory and add the following variables:

```bash
PROJECT_NAME=JobReferralPlatform
VITE_APP_NETWORK=testnet
VITE_MODULE_ADDRESS=0x2abb1ab290cb828323bf6da71a3f36011d59cd7aa576474f19dbcae50521e056
```

Adjust the **VITE_MODULE_ADDRESS** to match your deployed smart contract address.

### 4. Run the Development Server

```bash
npm run dev
```

The app will be available at [http://localhost:5173](http://localhost:5173).

### 5. Deploy the Smart Contract

To deploy the smart contract:

1.  Install **Aptos CLI**.
2.  Update the **Move.toml** file with your wallet address:

    - Add you Wallet Address from Petra here

    ```bash
    sys_addrx = "0xca10b0176c34f9a8315589ff977645e04497814e9753d21f7d7e7c3d83aa7b57"
    ```

    - Add your Account addr here for Deployment

    ```bash
    my_addrx = "2abb1ab290cb828323bf6da71a3f36011d59cd7aa576474f19dbcae50521e056"
    ```

3.  Create your new Address for Deployment

    ```bash
    aptos init
    ```

4.  Compile and publish the contract:

    ```bash
    aptos move compile
    aptos move publish
    ```

---

## 🛠 How to Use the Platform

### 1. Connect Wallet

- Upon opening the app, click **"Connect Wallet"** to link your Aptos wallet (e.g., **Petra Wallet**).
- This allows you to interact with the blockchain and perform actions such as referring candidates and posting jobs.

### 2. Browse Jobs

- Go to the **Jobs** section to view available job listings.
- Each job displays details, including:
  - **Title** and **description**
  - **Finder’s fee** in APT
  - **Posting date** and **employer details**

### 3. Refer a Candidate

- Select a job listing that matches the candidate's profile.
- Provide the candidate’s details and a custom referral message.
- Submit the referral, which will be securely recorded on the blockchain for the employer’s review.

### 4. Confirm a Hire (Employers Only)

- Navigate to **Manage Jobs** to view posted jobs and their referrals.
- Review candidate referrals and confirm a hire.
- Once confirmed, the finder’s fee will be automatically transferred to the referrer’s wallet.

---

## 📊 Scripts

- **`npm run dev`**: Start the development server locally.
- **`npm run build`**: Build the project for production.
- **`npm test`**: Run unit tests (if available).

---

## 🔍 Dependencies

- **React**: UI library for building user interfaces.
- **TypeScript**: Typed JavaScript for better development.
- **Aptos SDK**: JavaScript SDK for Aptos blockchain interaction.
- **Ant Design / Tailwind CSS**: For modern UI design and responsive layouts.
- **Petra Wallet Adapter**: To connect and interact with the Aptos wallet.

---

## 📚 Available View Functions

- **View All Jobs**: Displays all job postings on the platform.
- **View Jobs by Employer**: Lists jobs posted by a specific employer.
- **View Referrals by User**: Shows all referrals made by a specific user.
- **View Job by ID**: Provides detailed information about a specific job listing.

---

## 🛡 Security and Transparency

- **Smart Contracts**: Manage all payments and referrals on-chain, ensuring transparency and eliminating intermediaries.
- **Finder’s Fees**: Automatically released upon confirmation of a hire, ensuring prompt rewards.
- **Progress Tracking**: Employers and users can monitor job status and referral outcomes in real-time.

---

## 🌐 Common Issues and Solutions

1. **Wallet Connection Issues**: Ensure the Aptos wallet extension (e.g., Petra Wallet) is installed and active.
2. **RPC Rate Limits**: Use private RPC providers like **Alchemy** or **QuickNode** to avoid rate limits.
3. **Transaction Errors**: Verify that your wallet has enough balance and permissions for the operation.

---

## 🚀 Scaling and Deployment

If deploying to **Vercel**, consider these optimizations:

- Use **third-party RPC providers** (e.g., **Alchemy**, **QuickNode**) for reliable blockchain interaction.
- Implement **request throttling** to manage RPC load and avoid rate limits.
- Use **WebSockets** for real-time updates on job status and referral confirmations.

---

## 🎉 Conclusion

The **JobReferralPlatform** offers a decentralized solution for managing job referrals and hiring. By using smart contracts on the Aptos blockchain, it ensures trust, transparency, and secure transactions between employers and referrers. Get started today by posting jobs, making referrals, and earning rewards on this decentralized platform!
