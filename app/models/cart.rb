class Cart < ActiveRecord::Base
    has_many :tickets
    attr_accessible :purchased_at, :placed_at, :order_firstname, :order_lastname, :order_email
    validates_presence_of :order_firstname, :if => :placed_at? 
    validates_presence_of :order_lastname, :if => :placed_at?
    validate :tickets_still_available?, :if => :placed_at?

    def add_ticket(perf_id, quantity)
        performance = Performance.find(perf_id)
        if performance and not performance.sold_out?
            ticket = Ticket.find_by_cart_id_and_performance_id(self.id, perf_id)
            if ticket
                ticket.quantity += quantity.to_i
            else
                ticket = Ticket.new(performance_id: perf_id, cart_id: self.id, quantity: quantity)
            end
            return ticket
        else
            return nil
        end
    end
    def paypal_url(return_url, notify_url)
        values = {
            :business => APP_CONFIG[:paypal_email],
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

    def paypal_encrypted_url(return_url, notify_url)
        values = {
            :business => APP_CONFIG[:paypal_email],
            :cmd => '_cart',
            :upload => 1,
            :return => return_url,
            :invoice => id,
            :notify_url => notify_url,
            :cert_id => APP_CONFIG[:paypal_cert_id]
        }

        tickets.each_with_index do |item, index|
            values.merge!({
                "amount_#{index + 1}" => to_price_string(item.performance.price * item.quantity),
                "item_name_#{index + 1}" => item.performance.show.title,
                "item_number_#{index + 1}" => item.performance.id,
                "quantity_#{index + 1}" => 1
            })
        end
        return  encrypt_for_paypal(values)
    end
    private

    PAYPAL_CERT_PEM = File.read("#{Rails.root}/certs/paypal_cert.pem")
    APP_CERT_PEM = File.read("#{Rails.root}/certs/app_cert.pem")
    APP_KEY_PEM = File.read("#{Rails.root}/certs/app_key.pem")

    def encrypt_for_paypal(values)
        signed = OpenSSL::PKCS7::sign(OpenSSL::X509::Certificate.new(APP_CERT_PEM),
                                      OpenSSL::PKey::RSA.new(APP_KEY_PEM, ''), 
                                      values.map { |k, v| "#{k}=#{v}" }.join("\n"), 
                                      [], 
                                      OpenSSL::PKCS7::BINARY)
        OpenSSL::PKCS7::encrypt(
            [OpenSSL::X509::Certificate.new(PAYPAL_CERT_PEM)], 
            signed.to_der, 
            OpenSSL::Cipher::Cipher::new("DES3"),
            OpenSSL::PKCS7::BINARY).to_s.gsub("\n", "")
    end

    def tickets_still_available?
        self.tickets.each do |t| 
            if not t.still_available?
                errors.add(:base, "One or more of the shows in your cart is sold out.")
                return false
            end
        end
        return true
    end

    def to_price_string(price)
        return "%d.%d" % [price / 100, price % 100]
    end
end
