export const paymentData = {
  aiJobApply: {
    id: "ai-job-apply",
    title: "AI Job Apply",
    price: 200,
    priceId: process.env.NEXT_PUBLIC_NODE_ENV === "development" ? "price_1RuW0VB1BQRwW7MafDpy13TI" : "price_1RmrpuCuDksz8I2dB3DogplI",
    description: "AI matches your CV to the best 200 jobs from our database and applies on your behalf.",
    link: "https://buy.stripe.com/cNi5kCbAJ2Od1Kd23p2Ji05",
    features: [
      "AI matches your CV to the best 200 jobs",
      "Automatic job applications",
      "Smart job matching algorithm"
    ]
  },
  linkedinOptimization: {
    id: "linkedin-optimization",
    title: "LinkedIn Optimization",
    price: 60,
    priceId: process.env.NEXT_PUBLIC_NODE_ENV === "development" ? "price_1RuW2xB1BQRwW7MaHP7rfRw1" : "price_1RmrmgCuDksz8I2d7NljczWE",
    description: "Enhance your professional presence with a profile that stands out to recruiters.",
    link: "https://buy.stripe.com/14A5kC6gpcoN60tazV2Ji01",
  },
  cvTransformer: {
    id: "ai-resume-optimization",
    title: "ATS CV",
    price: 40,
    link: "https://buy.stripe.com/eVqdR834dagF4Wp9vR2Ji00",
    priceId: process.env.NEXT_PUBLIC_NODE_ENV === "development" ? "price_1RuW4CB1BQRwW7Mae8sACill" : "price_1Rm5F9CuDksz8I2d0dwabF35",
    description: "Optimize your CV for Applicant Tracking Systems to increase your chances of getting noticed."
  },
  // coverLetterGeneration: {
  //   id: "cover-letter-generation",
  //   title: "Cover Letter Generation",
  //   price: 25,
  //   link: "https://buy.stripe.com/eVqdR834dagF4Wp9vR2Ji00",
  //   priceId: "price_1Rm5F9CuDksz8I2d0dwabF35",
  // },
  interview: {
    id: "interview-training",
    title: "Interview Training",
    price: 150,
    link: "https://buy.stripe.com/5kQ6oG5cl9cBewZ7nJ2Ji03",
    priceId: process.env.NEXT_PUBLIC_NODE_ENV === "development" ? "price_1RuW4kB1BQRwW7MazyUHZ0sB" : "price_1RmropCuDksz8I2dtFMBhifY",
    description: "Gain confidence and skills with tailored interview preparation and strategies.",
    
  }
};