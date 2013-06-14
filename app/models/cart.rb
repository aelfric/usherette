class Cart < ActiveRecord::Base
    has_many :tickets
    # attr_accessible :title, :body
    attr_accessible :purchased_at
    def add_ticket(perf_id)
        performance = Performance.find(perf_id)
        if performance
            return Ticket.new(performance_id: perf_id, cart_id: self.id)
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
                "amount_#{index + 1}" => item.performance.price_string,
                "item_name_#{index + 1}" => item.performance.show.title,
                "item_number_#{index + 1}" => item.performance.id,
                "quantity_#{index + 1}" => 1
            })
        end
        "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
    end
end
