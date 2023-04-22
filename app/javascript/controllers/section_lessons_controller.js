import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["link", "lessons"]

  connect() {
    console.log("connected");
    this.linkTargets.forEach(link => {
      link.addEventListener("mouseover", this.showLessons)
      link.addEventListener("click", this.loadLessons)
    })
  }

  disconnect() {
    this.linkTargets.forEach(link => {
      link.removeEventListener("mouseover", this.showLessons)
      link.removeEventListener("click", this.loadLessons)
    })
  }

  showLessons = (event) => {
    console.log(event, "showLessons");
    const sectionId = event.currentTarget.dataset.sectionId
    const url = `/sections/${sectionId}/lessons`
  
    fetch(url)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.text();
      })
      .then(html => {
        this.lessonsTarget.innerHTML = html
      })
      .catch(error => {
        console.error('Error fetching lessons:', error);
      });
  }

  loadLessons = (event) => {
    const sectionId = event.currentTarget.dataset.sectionId
    const url = `/sections/${sectionId}/lessons`

    fetch(url)
      .then(response => response.text())
      .then(html => {
        this.lessonsTarget.innerHTML = html
      })
  }
}
