module ApplicationHelper
    def tab_link_to(name, path, active = false)
        name = link_to(raw(name), path)
        if active
            name = '<li class="active">' + name + '</li>'
        else
            name = '<li>' + name + '</li>'
        end
        render :inline => name
    end
end