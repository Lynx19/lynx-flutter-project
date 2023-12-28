import React from 'react'

const Chooseus = () => {
  return (
    <div id='chooseus' className='text-center bg-sky-950 text-white pt-5'>
         <h1 className='text-white font-thin'>Why Choose <span className='text-yellow-400'>US</span> </h1>
      <div className='w-full py-[10rem] px-4'>
        <div className='max-w-[1240px] mx-auto grid md:grid-cols-3 gap-8'>
             <div className='w-full flex-col p-4 rounded-lg'>
             <img className='w-20 mx-auto mt-[-3rem]' src="/assets/partner.png" alt="/" />
                <h2 className='text-2xl font-bold text-center py-2'>Professional Management</h2>
                <div className='text-center font-medium'>
                        <p className='text-justify'>
                        Touch IT excels in delivering cutting-edge IT solutions with a client-centric focus. 
                        Our experienced leadership ensures strategic planning, innovation, and operational
                        excellence. We prioritize tailored services, strategic partnerships, and continuous 
                        improvement to set benchmarks in the dynamic IT landscape. Partner with us for transformative,
                        efficient, and reliable technology solutions.
                        </p>
                </div>
            </div>
            <div className='w-full flex-col p-4 rounded-lg'>
             <img className='w-20 mx-auto mt-[-3rem]' src="/assets/w2.png" alt="/" />
                <h2 className='text-2xl font-bold text-center py-2'>Technological Inclusion</h2>
                <div className=' font-medium text-center'>
                        <p className='text-justify'>
                        Touch IT provides tailored IT solutions. Our seasoned leadership ensures strategic 
                        planning, innovation, and operational excellence. We prioritize client-centricity,
                        strategic partnerships, and continuous improvement. Harness transformative,
                        efficient, and reliable technology solutions with us, driving your business into the future.
                        </p>
                </div>
            </div>
            <div className='w-full flex-col p-4 rounded-lg'>
             <img className='w-20 mx-auto mt-[-3rem]' src="/assets/w4.png" alt="/" />
                <h2 className='text-2xl font-bold text-center py-2'>Product and Innovation</h2>
                <div className='text-center font-medium'>
                        <p className='text-justify'>
                        Our cutting-edge products redefine possibilities, crafted with agile
                        development and user-centric design. Embrace the future with seamlessly 
                        integrated, scalable solutions that anticipate industry shifts. 
                        Partner with us for a tech-driven journey of excellence.
                        </p>
                </div>
            </div>
        </div>
      </div>
    </div>
  )
}

export default Chooseus
