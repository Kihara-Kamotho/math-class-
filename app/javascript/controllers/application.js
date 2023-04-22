import { Application } from "@hotwired/stimulus"
import SectionLessonsController from "./section_lessons_controller"

const application = Application.start()
application.register("section-lessons", SectionLessonsController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
