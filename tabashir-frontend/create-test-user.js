const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();
const bcrypt = require('bcryptjs');

async function createTestUser() {
  try {
    // Hash password
    const hashedPassword = await bcrypt.hash('password123', 10);

    // Create user
    const user = await prisma.user.create({
      data: {
        id: 'test-user-id',
        email: 'test@example.com',
        name: 'Test User',
        password: hashedPassword,
        userType: 'CANDIDATE',
      }
    });

    console.log('User created:', user.id);

    // Create candidate profile
    const candidate = await prisma.candidate.create({
      data: {
        userId: user.id,
      }
    });

    console.log('Candidate created:', candidate.id);
    console.log('\nTest credentials:');
    console.log('  Email: test@example.com');
    console.log('  Password: password123');

  } catch (error) {
    if (error.code === 'P2002') {
      console.log('Test user already exists');
    } else {
      console.error('Error:', error.message);
      console.error(error.stack);
    }
  } finally {
    await prisma.$disconnect();
  }
}

createTestUser();
