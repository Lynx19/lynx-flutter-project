import React from 'react'
import Link from 'next/link'

const About = () => {
  return (
    <div id='about' className='w-full md:h-screen p-2 flex items-center'>
      <div className='max-w-[1240px m-auto md:grid grid-cols-3 gap-8]'>
        <div className='cols-span-3'>
        <h1 className='text-gray-700 tracking-widest'>About <span className='text-blue-800'>Us</span> </h1>
        <h2 className='py-4 text-gray-700'>We are Touch IT</h2>
        <p className='py-2 text-gray-600 text-justify'>
        Touch IT is a firm dedicated to making the integration
        of Technology easy in our communities with the development
        of applications, APIs and softwares with easy use interfaces
        </p>
        <div>
          <Link href={'/#chooseus'}>
           <button className='bg-blue-700 font-medium w-[150px] hover:scale-105'>Read more</button>
          </Link>
        </div>
        </div>
        <div className='w-full h-auto m-auto shadow-xl shadow-gray-400 rounded-xl justify-center p-4 hover:scale-105 ease-in duration-300'>
            <img className='rounded-xl' src="https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bGFwdG9wfGVufDB8fDB8fHww" alt="" />
        </div>
      </div>
    </div>
  )
}

export default About
