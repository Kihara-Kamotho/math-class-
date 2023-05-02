import { Application } from "@hotwired/stimulus"
import SectionLessonsController from "./section_lessons_controller"
import UnsubscribedLessonsController from "./unsubscribed_lessons_controller"

const application = Application.start()
application.register("section-lessons", SectionLessonsController)
application.register("unsubscribed-lessons", UnsubscribedLessonsController)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
