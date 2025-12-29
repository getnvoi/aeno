import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    duration: { type: Number, default: 5000 },
  };

  connect() {
    // Auto-dismiss after duration
    if (this.durationValue > 0) {
      this.startTimer();
    }

    // Listen for animation end to remove from DOM
    this.element.addEventListener(
      "animationend",
      this.handleAnimationEnd.bind(this),
    );
  }

  disconnect() {
    this.clearTimer();
  }

  startTimer() {
    this.clearTimer();
    this.timeout = setTimeout(() => this.dismiss(), this.durationValue);
  }

  clearTimer() {
    if (this.timeout) {
      clearTimeout(this.timeout);
      this.timeout = null;
    }
  }

  pauseTimer() {
    this.clearTimer();
  }

  resumeTimer() {
    if (this.durationValue > 0) {
      this.startTimer();
    }
  }

  // Swipe gesture support
  startSwipe(event) {
    this.swipeStartX = event.clientX || event.touches?.[0]?.clientX;
    this.swiping = true;
    this.pauseTimer();
  }

  moveSwipe(event) {
    if (!this.swiping) return;

    const currentX = event.clientX || event.touches?.[0]?.clientX;
    const diff = currentX - this.swipeStartX;

    if (diff > 0) {
      this.element.style.transform = `translateX(${diff}px)`;
      this.element.style.opacity = Math.max(0, 1 - diff / 200);
    }
  }

  endSwipe(event) {
    if (!this.swiping) return;

    const currentX = event.clientX || event.changedTouches?.[0]?.clientX;
    const diff = currentX - this.swipeStartX;

    if (diff > 100) {
      this.dismiss();
    } else {
      this.element.style.transform = "";
      this.element.style.opacity = "";
      this.resumeTimer();
    }

    this.swiping = false;
  }

  dismiss() {
    this.clearTimer();
    this.element.dataset.state = "exiting";
    this.element.classList.remove("animate-toast-enter");
    this.element.classList.add("animate-toast-exit");
  }

  handleAnimationEnd(event) {
    // Only remove on exit animation
    if (event.animationName === "toast-exit") {
      this.element.remove();
    }
  }
}
