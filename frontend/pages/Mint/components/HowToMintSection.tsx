interface HowToMintSectionProps {}

export const HowToMintSection: React.FC<HowToMintSectionProps> = () => {
  return (
    <section className="how-to-mint-container px-4 text-center max-w-screen-xl mx-auto w-full">
      <h2 className="heading-md">How Use the App</h2>

      <ol className="flex flex-col md:flex-row items-center md:justify-between pt-6 gap-6">
        {["Connect Your Wallet", "Create Job", "Give Your Referral", "Earn Reward if you candidate gets hired ヅ"].map(
          (text, index) => (
            <li key={index} className="flex items-center gap-4 basis-1/4">
              <span className="title-md text-secondary-text">{index + 1}</span>
              <p className="body-sm text-left">{text}</p>
            </li>
          ),
        )}
      </ol>
    </section>
  );
};
