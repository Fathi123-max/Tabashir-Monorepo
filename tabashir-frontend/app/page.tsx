import React from 'react'
import { auth } from './utils/auth'
import { redirect } from 'next/navigation'

const HomePage = async () => {
  const session = await auth()

  if (!session || !session.user) {
    return redirect("/candidate/login")
  }

  if (session.user && session.user.userType === "CANDIDATE") {
    return redirect("/dashboard")
  }
  if (session.user && session.user.userType === "ADMIN") {
    return redirect("/admin/dashboard")
  }
  console.log(session.user)
  if (session.user && session.user.userType === "RECURITER") {
    return redirect("/recruiter/dashboard")
  }
  return <h2>redirecting...</h2>
}

export default HomePage
