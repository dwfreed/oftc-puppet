class oftc::www {
  ensure_packages([
    'apache2',
    'jekyll',
    'ruby-gsl',
  ])
  include acme_tiny
}
