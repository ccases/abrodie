# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
# pin "materialize-css", to: "https://ga.jspm.io/npm:materialize-css@1.0.0/dist/js/materialize.js"
# pin "@materializecss/materialize", to: "https://ga.jspm.io/npm:@materializecss/materialize@1.1.0-alpha/dist/js/materialize.js"
