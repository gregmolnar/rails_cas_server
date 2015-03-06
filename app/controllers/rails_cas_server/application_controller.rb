module RailsCasServer
  class ApplicationController < ActionController::Base
    ensure_security_headers(
      hsts: { include_subdomains: false, max_age: 20.years.to_i},
      x_frame_options: 'DENY',
      csp: {
        default_src: 'https: self',
        img_src: 'https:'
      }
    )
  end
end
