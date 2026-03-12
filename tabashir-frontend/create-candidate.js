const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function main() {
  try {
    // Get user by email
    const user = await prisma.user.findUnique({
      where: { email: 'testuser@example.com' },
    });
    
    console.log('User found:', user ? { id: user.id, email: user.email } : 'NOT FOUND');
    
    if (!user) {
      console.log('User not found!');
      return;
    }
    
    // Check if candidate already exists
    const existingCandidate = await prisma.candidate.findUnique({
      where: { userId: user.id },
    });
    
    if (existingCandidate) {
      console.log('Candidate already exists:', existingCandidate);
      return;
    }
    
    // Create candidate profile
    const candidate = await prisma.candidate.create({
      data: {
        userId: user.id,
      },
    });
    
    console.log('✅ Candidate created successfully!');
    console.log('Candidate ID:', candidate.id);
  } catch (error) {
    console.error('Error:', error);
  }
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
