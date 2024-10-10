# JobReferralPlatform - Frontend

This is the frontend for the **JobReferralPlatform** built on the **Aptos Blockchain**. The platform allows employers to post job listings, users to refer candidates, and employers to confirm hires, rewarding referrers with a finder’s fee through smart contract interactions.

## Key Features

- **View Available Jobs**: Users can browse job listings posted by employers.
- **Refer Candidates**: Users can refer candidates to posted jobs with custom messages.
- **Confirm Hire**: Employers can confirm a hire and automatically transfer the finder’s fee to the referrer.
- **Manage Jobs**: Employers can view and manage their posted jobs and candidate referrals.
- **Transaction Handling**: All payments and referrals are securely handled through smart contracts on the Aptos blockchain.

## Prerequisites

Before running the project, ensure you have the following installed:

- **Node.js** (version 16 or higher)
- **npm** or **yarn**
- **Aptos Wallet** extension (e.g., Petra Wallet) for blockchain interactions

## Setup Instructions

### 1. Clone the Repository

First, clone the project repository to your local machine:

```bash
git clone https://github.com/your-repo/job-referral-platform.git
cd job-referral-platform
```

### 2. Install Dependencies

Install the necessary dependencies for the project using **npm** or **yarn**:

```bash
npm install
```

or

```bash
yarn install
```

### 3. Configure Environment Variables

You need to configure the environment variables for the frontend to interact with the Aptos blockchain. Create a `.env` file in the project root and add the following variables:

```bash
PROJECT_NAME=JobReferralPlatform
VITE_APP_NETWORK=testnet
VITE_MODULE_ADDRESS=0x<your_contract_address>
```

Adjust the `VITE_APP_NETWORK` and `VITE_MODULE_ADDRESS` as per your deployment setup.

### 4. Run the Development Server

Start the development server by running:

```bash
npm run dev
```

or

```bash
yarn run dev
```

The app will be available at `http://localhost:5173`.

## How to Use the Platform

### 1. Connect Wallet

Upon opening the application, you'll be prompted to connect your Aptos wallet (e.g., Petra Wallet). This allows you to interact with the blockchain and perform operations such as referring candidates and posting jobs.

### 2. View Available Jobs

Users can browse the **Jobs** section to view the available job listings. Each listing will display details such as:

- Job title and description
- Finder's fee amount (paid in Aptos native token **APT**)
- Job posting date
- Employer details

### 3. Refer a Candidate

To refer a candidate for a job:

- Select the job you want to refer a candidate for.
- Enter the candidate’s details and provide a referral message.
- Submit the referral, which will be recorded on the blockchain and made available for the employer to review.

### 4. Confirm Hire (Employer)

Employers can confirm hires by:

- Navigating to the **Manage Jobs** section.
- Selecting the job listing and reviewing the referrals.
- Confirming the hire, which will trigger the release of the finder’s fee to the referrer’s wallet.

## Scripts

- **`npm run dev`**: Starts the development server.
- **`npm run build`**: Builds the project for production.
- **`npm test`**: Runs unit tests.

## Dependencies

The project uses the following key dependencies:

- **React**: UI library for building user interfaces.
- **TypeScript**: Typed superset of JavaScript for type-safe development.
- **Aptos SDK**: JavaScript/TypeScript SDK to interact with the Aptos blockchain.
- **Ant Design / Tailwind CSS**: For responsive UI design and layout.
- **Petra Wallet Adapter**: To connect and interact with the Aptos wallet.

## Conclusion

This frontend allows users to seamlessly interact with the **JobReferralPlatform**, offering a decentralized and transparent way for employers to manage job postings and for referrers to earn finder’s fees through secure blockchain transactions.
