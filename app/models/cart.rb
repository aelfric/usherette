class Cart < ActiveRecord::Base
    has_many :tickets
    attr_accessible :purchased_at, :placed_at, :order_firstname, :order_lastname, :order_email
    validates_presence_of :order_firstname, :if => :placed_at? 
    validates_presence_of :order_lastname, :if => :placed_at?


    def add_ticket(perf_id)
        performance = Performance.find(perf_id)
        if performance
            ticket = Ticket.find_by_cart_id_and_performance_id(self.id, perf_id)
            if ticket
                ticket.quantity += 1
            else
                ticket = Ticket.new(performance_id: perf_id, cart_id: self.id)
            end
            return ticket
        else
            return nil
        end
    end
    def paypal_url(return_url, notify_url)
        values = {
            :business => 'friccobono@hopeforchange.org',
            :cmd => '_cart',
            :upload => 1,
            :return => return_url,
            :invoice => id,
            :notify_url => notify_url
        }

        tickets.each_with_index do |item, index|
            values.merge!({
                "amount_#{index + 1}" => to_price_string(item.performance.price * item.quantity),
                "item_name_#{index + 1}" => item.performance.show.title,
                "item_number_#{index + 1}" => item.performance.id,
                "quantity_#{index + 1}" => 1
            })
        end
        "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    end

    private

    def to_price_string(price)
        return "%d.%d" % [price / 100, price % 100]
    end
end
