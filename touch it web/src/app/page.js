import Navbar from './components/navbar';
import Main from './components/main';
import About from './components/About';
import Services from './components/Services';
import Chooseus from './components/Chooseus';
import Contact from './components/contact';
export default function Home() {
  return (
    <div>
    <Navbar/>
    <Main/>
    <Services/>
    <About/>
    <Chooseus/>
    <Contact/>
  </div>
      );
}
