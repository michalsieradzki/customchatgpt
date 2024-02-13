class ChatService
  attr_reader :message

  def initialize(message:)
    @message = message
  end
  
  def call
    messages = training_prompts.map do |prompt| 
      { role: "system", content: prompt }
    end


    messages << { role: "user", content: message }
    #create the chat gpt client
    
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: messages,
        temperature: 0.7,
        
      }
    )
    puts response
    response.dig("choices", 0, "message", "content")


  end

  private

  def training_prompts
    [
      "Twoim zadaniem jest sklasyfikowanie zapytań wysyłanych przez klientów aplikacji służącej do rezerwacji biur. Zapytania wysyłane przez klientów muszą być przydzielane do jednej z poniższej grupy:

      1.  Dostępność biur
      2. Informacje dotyczące dostępnych pakietów
      3.  Uwagi techniczne i usterki
      4. Zapytania niezwiązane z żadną kategorią
      
      Twoim zdaniem jest odesłanie krótkiej i zwięzłej odpowiedzi zawierającej tylko numer grupy do której dane zapytanie twoim zdaniem powinno być przydzielone.",
        
    ]
  end

  def client
    @_client ||= OpenAI::Client.new(access_token: ENV.fetch("OPENAI_ACCESS_TOKEN"))
  end
end