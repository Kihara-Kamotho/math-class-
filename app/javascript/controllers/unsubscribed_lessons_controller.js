import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["link"]
    connect() {
        this.linkTargets.forEach(link => {
            link.addEventListener("click", this.showPrompt)
        })
    }


    showPrompt(event) {
        // on click, dont redirect
        event.preventDefault();
        const promptElement = document.getElementById('prompt-message');
        if (promptElement) {
            promptElement.innerText = 'Please subscribe to view content';
        }
    }

}
