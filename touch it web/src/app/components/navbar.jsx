'use client';
import Link from "next/link";
import React, {useState, useEffect} from "react";
import { AiOutlineClose, AiOutlineMail, AiOutlineMenu, } from "react-icons/ai";
import {FaGithub, FaLinkedinIn} from "react-icons/fa";

const Navbar = () => {
    const [navOpen, setNavOpen] = useState(false);
    const [shadow, setShadow] = useState(false);

  const handleNavToggle = () => {
    setNavOpen(!navOpen);
  };
    useEffect(() => {
        const handleShadow = () => {
            if (window.scrollY >=90){
                setShadow(true);
            }else {
                setShadow(false);
            }
        }
        window.addEventListener('scroll', handleShadow);
    },[]);

    return (
        <div className= {shadow ? "fixed w-full h-20 shadow-xl z-[100] bg-sky-950" : "fixed w-full h-20 z-[100]"}>
            <div className="flex justify-between items-center w-full h-full px-2 2xl:px-16">
                <img src="/assets/touch2.png" alt="touchit logo" width="125" height="50" />
                <div>
                    <ul className="hidden md:flex">
                        
                            
                                <Link href={'/'}>
                                <li className='ml-10 text-sm uppercase hover: border-b text-white'>Home</li>
                                </Link>
                                <Link href={'/#services'}>
                                <li className='ml-10 text-sm uppercase hover: border-b text-white'>Services</li>
                                </Link>
                            
                                <Link href={'/#about'}>
                                <li className='ml-10 text-sm uppercase hover: border-b text-white'>About</li>
                                </Link>
                                <Link href={'/#contact'}>
                                <li className='ml-10 text-sm uppercase hover: border-b text-white'>Contact</li>
                                </Link>
                             
                        
                    </ul>
                    <div onClick={handleNavToggle} className="md:hidden">
                        <AiOutlineMenu className="fill-white" size={30}/>
                    </div>
                </div>
            </div>
            <div className={navOpen ? "md:hidden fixed left-0 top-0 w-full h-screen bg-black/70" : ''}>
                    <div className={navOpen ? 'fixed left-0 top-0 w-[75%] sm:w-[60%] md:w-[45%] h-screen bg-white p-10 ease-in duration-500' : 'hidden'}>
                        <div>
                            <div className="flex w-full items-center justify-between">
                            <img src="/assets/touch.png" alt="touchit logo" width="87" height="35" />
                            <div onClick={handleNavToggle} className="rounded-full shadow-lg shadow-gray-400 p-3 cursor-pointer">
                                <AiOutlineClose/>
                            </div>
                            </div>
                            <div className="border-b border-gray-300 my-4">
                                <p className="w-[85%] md:w-[90%] py-4">Let Us lead you into the digital age</p>
                            </div>
                        </div>
                        <div className="py-4 flex-col">
                            <ul>
                                <Link href={'/'}>
                                    <li onClick={() => setNavOpen(false)} className="py-4 text-sm">Home</li>
                                </Link>

                                <Link href={'/#services'}>
                                    <li onClick={() => setNavOpen(false)} className="py-4 text-sm">Services</li>
                                </Link>

                                <Link href={'/#about'}>
                                    <li onClick={() => setNavOpen(false)} className="py-4 text-sm">About Us</li>
                                </Link>

                                <Link href={'/'}>
                                    <li onClick={() => setNavOpen(false)} className="py-4 text-sm">Contact</li>
                                </Link>
                            </ul>
                            <div className="pt-40">
                                    <p className="uppercase tracking-widest text-blue-700">Let's Connect</p>
                                    <div className="flex items-center justify-between my-4 w-full sm:w-[80%]">
                                        <div className="rounded-full shadow-lg shadow-gray-400 p-3 cursor-pointer hover:scale-105 ease-in duration-300">
                                        <FaLinkedinIn/>
                                        </div>
                                        <div className="rounded-full shadow-lg shadow-gray-400 p-3 cursor-pointer hover:scale-105 ease-in duration-300">
                                        <FaGithub/>
                                        </div>
                                        <div className="rounded-full shadow-lg shadow-gray-400 p-3 cursor-pointer hover:scale-105 ease-in duration-300">
                                        <AiOutlineMail/>
                                        </div>
                                    </div>
                            </div>
                        </div>
                </div>
                
            </div>
        </div>
    );
};

export default Navbar;
