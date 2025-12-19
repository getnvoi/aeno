import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["batchToolbar", "selectedCount", "headerCheckbox", "rowCheckbox"]
  static values = {
    selectedIds: { type: Array, default: [] },
    debounce: { type: Number, default: 300 },
    url: String
  }

  connect() {
    this.updateHeaderState()
    this.updateBatchToolbar()
  }

  // Navigate with scroll preservation
  navigateWithScroll(url) {
    const scrollY = window.scrollY

    Turbo.visit(url, { action: "replace" })

    document.addEventListener("turbo:load", () => {
      window.scrollTo(0, scrollY)
    }, { once: true })
  }

  // Toggle all rows
  toggleAll(event) {
    const checked = event.target.checked
    this.rowCheckboxTargets.forEach(checkbox => {
      checkbox.checked = checked
    })
    this.updateSelectedIds()
  }

  // Toggle individual row
  toggleRow(event) {
    this.updateSelectedIds()
    this.updateHeaderState()
  }

  // Update the array of selected IDs
  updateSelectedIds() {
    this.selectedIdsValue = this.rowCheckboxTargets
      .filter(cb => cb.checked)
      .map(cb => cb.dataset.rowId)
    this.updateBatchToolbar()
  }

  // Update header checkbox state (checked/unchecked/indeterminate)
  updateHeaderState() {
    if (!this.hasHeaderCheckboxTarget) return

    const total = this.rowCheckboxTargets.length
    const checked = this.selectedIdsValue.length

    if (checked === 0) {
      this.headerCheckboxTarget.checked = false
      this.headerCheckboxTarget.indeterminate = false
    } else if (checked === total) {
      this.headerCheckboxTarget.checked = true
      this.headerCheckboxTarget.indeterminate = false
    } else {
      this.headerCheckboxTarget.checked = false
      this.headerCheckboxTarget.indeterminate = true
    }
  }

  // Show/hide batch toolbar and update count
  updateBatchToolbar() {
    if (!this.hasBatchToolbarTarget) return

    const count = this.selectedIdsValue.length

    if (count > 0) {
      this.batchToolbarTarget.classList.remove('hidden')
      this.selectedCountTarget.textContent = `${count} selected`
    } else {
      this.batchToolbarTarget.classList.add('hidden')
    }
  }

  // Search with debounce
  search(event) {
    clearTimeout(this.searchTimeout)

    const input = event.target
    const url = input.dataset.aeno__tableUrlValue || window.location.pathname
    const debounce = parseInt(input.dataset.aeno__tableDebounceValue) || 300

    this.searchTimeout = setTimeout(() => {
      const searchParams = new URLSearchParams(window.location.search)
      const value = input.value.trim()

      if (value) {
        searchParams.set(input.name, value)
      } else {
        searchParams.delete(input.name)
      }

      const newUrl = `${url}?${searchParams.toString()}`
      this.navigateWithScroll(newUrl)
    }, debounce)
  }

  // Perform batch action (button click)
  performAction(event) {
    const button = event.currentTarget
    const baseUrl = button.dataset.aeno__tableUrlValue
    const method = button.dataset.aeno__tableMethodValue || 'get'

    if (this.selectedIdsValue.length === 0) {
      alert('Please select at least one item')
      return
    }

    const url = this.buildActionUrl(baseUrl, {})

    if (method === 'get') {
      Turbo.visit(url)
    } else {
      // For non-GET methods, submit as form
      const form = document.createElement('form')
      form.method = 'post'
      form.action = url

      // Add CSRF token
      const csrfToken = document.querySelector('meta[name="csrf-token"]').content
      const csrfInput = document.createElement('input')
      csrfInput.type = 'hidden'
      csrfInput.name = 'authenticity_token'
      csrfInput.value = csrfToken
      form.appendChild(csrfInput)

      // Add method if not POST
      if (method !== 'post') {
        const methodInput = document.createElement('input')
        methodInput.type = 'hidden'
        methodInput.name = '_method'
        methodInput.value = method
        form.appendChild(methodInput)
      }

      document.body.appendChild(form)
      form.submit()
    }
  }

  // Perform filter action (select change)
  performFilterAction(event) {
    const select = event.target
    const baseUrl = select.dataset.aeno__tableUrlValue || window.location.pathname

    const searchParams = new URLSearchParams(window.location.search)
    const value = select.value

    if (value) {
      searchParams.set(select.name, value)
    } else {
      searchParams.delete(select.name)
    }

    const newUrl = `${baseUrl}?${searchParams.toString()}`
    this.navigateWithScroll(newUrl)
  }

  // Clear all filters
  clearFilters(event) {
    const button = event.currentTarget
    const baseUrl = button.dataset.aeno__tableUrlValue || window.location.pathname

    this.navigateWithScroll(baseUrl)
  }

  // Change per page
  changePerPage(event) {
    const select = event.target
    const baseUrl = select.dataset.aeno__tableUrlValue || window.location.pathname

    const searchParams = new URLSearchParams(window.location.search)
    searchParams.set('per_page', select.value)
    searchParams.set('page', '1') // Reset to first page

    const newUrl = `${baseUrl}?${searchParams.toString()}`
    this.navigateWithScroll(newUrl)
  }

  // Build URL with selected IDs
  buildActionUrl(baseUrl, additionalParams = {}) {
    const url = new URL(baseUrl, window.location.origin)

    // Add selected IDs
    this.selectedIdsValue.forEach(id => {
      url.searchParams.append('ids[]', id)
    })

    // Add additional params
    Object.entries(additionalParams).forEach(([key, value]) => {
      url.searchParams.append(key, value)
    })

    return url.toString()
  }
}
