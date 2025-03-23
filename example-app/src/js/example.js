import { FastGeolocation } from 'fast-geolocation';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    FastGeolocation.echo({ value: inputValue })
}
