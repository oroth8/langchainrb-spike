require 'openai'
require 'langchainrb'

class OpenAiService
  def initialize
    # Initialize with your API key
    @access_token = Rails.application.credentials.dig(:openai, :api_key)
    @llm = Langchain::LLM::OpenAI.new(api_key: @access_token)

    # Attaching a vector database client is optional
    # @vector_db_client = Langchain::Vectorsearch::Weaviate.new(
    #   url: Rails.application.credentials.dig(:weaviate, :url),
    #   api_key: Rails.application.credentials.dig(:weaviate, :api_key),
    #   index_name: "YourIndexName",
    #   llm: @llm
    # )
  end

  def complete_text(prompt, options = {})
    # Generate a text completion
    response = safe_api_call do
      @llm.complete(prompt:, **options).completion
    end
    puts response
  end

  def chat_with_model(prompt, options = {})
    # Generate a chat completion
    response = safe_api_call do
      @llm.chat(prompt:, **options).completion
    end
    puts response
  end

  def summarize_text(text, options = {})
    # Summarize the provided text
    response = safe_api_call do
      @llm.summarize(text:, **options).completion
    end
    puts response
  end

  def use_prompt_template(template, input_variables)
    # Use a prompt template
    prompt = Langchain::Prompt::PromptTemplate.new(template:, input_variables:)
    formatted_prompt = prompt.format(input_variables)
    complete_text(formatted_prompt)
  end

  private

  def safe_api_call
    yield
  rescue StandardError => e
    # Handle different types of errors (e.g., network errors, API limits)
    puts "An error occurred: #{e.message}"
  end
end
