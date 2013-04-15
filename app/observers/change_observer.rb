# -*- encoding : utf-8 -*-
class ChangeObserver < ActiveRecord::Observer
  #*********************************
  # Work in progress... not working
  #*********************************

  observe xxx # Change 'xxx' with appropriate value !

  # When creating 'history' table, import initial state of houses.
  def after_create(xxx)
    import_openings_states(xxx)
    import_temp_values(xxx)  # Define what we have to import when creating 'history' table.
    import_rooms_sates(xxx)  # Check if useful !
  end

  # When something change in the house, get what changed and store it into 'history' table.
  def after_update(xxx)
    update_history(xxx) # update_profiles(xxx)
  rescue
  end

  # Private scope
  # =============
  private
    # Called after creation of the house to get all inital openings states.
    def import_openings_states(xxx)
      Openings.all(xxx).each do |opened|
        History.create( #:name => history.  #To Do: create new field in table to store what change !
                        :opened => history.value)
      end

    end

    # Called after creation of the house to get all inital temps values.
    def import_temp_values(xxx)
      Rooms.all(xxx).each do |temperature|
        History.create( :home_id => history.home_id,
                        :temperature => history.value)
      end

    end

    # Called after creation of the house to get all inital rooms' values states.
    # Check if useful !
    def import_rooms_sates(xxx)

    end


  def update_history(xxx)
    Rooms.all(xxx).each do |temperature|
      History.create( :home_id => history.home_id,
                        :temperature => history.value)
  end

end
