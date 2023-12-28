import React from 'react'

const Services = () => {
  return (
    <div id='services' className='text-center p-2'>
         <h1 className='text-gray-700 tracking-widest pt-3'>Our <span className='text-blue-800'>Services</span> </h1>
    <div className='w-full py-[10rem] px-4'>
      <div className='max-w-[1240px] mx-auto grid md:grid-cols-3 gap-8'>
        <div className='w-full shadow-xl flex-col p-4 rounded-lg hover:scale-105 hover:bg-sky-950 hover:text-white duration-300'>
                <img className='w-20 mx-auto mt-[-3rem]' src="/assets/browser.png" alt="/" />
                <h2 className='text-2xl font-bold text-center py-2'>API</h2>
                <p className='text-center text-xl font-bold py-2'>Development</p>
                <div className='text-center font-medium'>
                    <p>
                        We build and integrate Application programming 
                        interfaces
                    </p>
                </div>
        </div>
        <div className='w-full shadow-xl flex-col p-4 rounded-lg hover:scale-105 hover:bg-sky-950 hover:text-white duration-300'>
                <img className='w-20 mx-auto mt-[-3rem]' src="/assets/web.png" alt="/" />
                <h2 className='text-2xl font-bold text-center py-2'>Web</h2>
                <p className='text-center text-xl font-bold py-2'>Development</p>
                <div className='text-center font-medium'>
                    <p>
                        We build and integrate Application programming 
                        interfaces
                    </p>
                </div>
        </div>
        <div className='w-full shadow-xl flex-col p-4 rounded-lg hover:scale-105 hover:bg-sky-950 hover:text-white duration-300'>
                <img className='w-20 mx-auto mt-[-3rem] bg-white' src="/assets/mobile.png" alt="/" />
                <h2 className='text-2xl font-bold text-center py-2'>Mobile</h2>
                <p className='text-center text-xl font-bold py-2'>Development</p>
                <div className='text-center font-medium'>
                    <p>
                        We build and integrate Application programming 
                        interfaces
                    </p>
                </div>
        </div>
      </div>
    </div>
    </div>
  )
}

export default Services
