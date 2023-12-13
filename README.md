# OpenAiService in Rails Application

This README provides guidance on how to integrate and use the `OpenAiService` class in a Ruby on Rails application. The `OpenAiService` class is designed to interact with OpenAI's API using the `langchainrb` gem, enabling functionalities like text completion, chat completion, summarization, and the use of prompt templates.

## Prerequisites

- Ruby on Rails
- `openai` gem
- `langchainrb` gem

Ensure that you have Ruby on Rails and the required gems installed in your application. Add the `openai` and `langchainrb` gems to your Gemfile and run `bundle install`.

```ruby
gem 'openai'
gem 'langchainrb'
```

## Setup

1. **API Key**: Ensure you have an API key from OpenAI. This key is necessary to authenticate requests to OpenAI's API.

2. **Rails Credentials**: Store your OpenAI API key securely in Rails credentials.

   ```bash
   EDITOR="your_editor --wait" rails credentials:edit
   ```

   Add your OpenAI API key:

   ```yaml
   openai:
     api_key: <YOUR_OPENAI_API_KEY>
   ```

3. **Service File**: Create a file named `open_ai_service.rb` in your `app/services` directory with the following content:

   ```ruby
   # Content of the OpenAiService class
   ```

   Replace the placeholder with the actual implementation of `OpenAiService`.

## Usage

You can use the `OpenAiService` in various parts of your Rails application, such as in controllers, jobs, or even the Rails console.

### Examples

- **Text Completion**:

  ```ruby
  service = OpenAiService.new
  service.complete_text("Your prompt here")
  ```

- **Chat Completion**:

  ```ruby
  service = OpenAiService.new
  service.chat_with_model("Start a conversation here")
  ```

- **Summarize Text**:

  ```ruby
  service = OpenAiService.new
  service.summarize_text("Text to summarize")
  ```

- **Using Prompt Templates**:

  ```ruby
  service = OpenAiService.new
  service.use_prompt_template("Tell me a {adjective} joke about {content}.", {adjective: "funny", content: "chickens"})
  ```

## Implementing a Vector Database

Integrating a vector database with `OpenAiService` enhances its capabilities, allowing for operations like similarity search and data indexing. Here's how you can implement it:

1. **Choose and Add Dependency**: Select a vector database supported by `langchainrb`, such as Weaviate, and add its gem to your Gemfile.

   ```ruby
   gem 'weaviate-ruby', '~> 0.8.9'
   ```

2. **Initialize the Vector Database Client**: In your `OpenAiService`, initialize the client for the vector database:

   ```ruby
   require 'weaviate'

   class OpenAiService
     def initialize
       # Initialize OpenAI and vector database clients
       @vector_db_client = Langchain::Vectorsearch::Weaviate.new(
         url: ENV["WEAVIATE_URL"],
         api_key: ENV["WEAVIATE_API_KEY"],
         index_name: "YourIndexName",
         llm: @llm
       )
     end

     # Other methods...
   end
   ```

3. **Add Vector Database Operations**: Create methods for adding data, performing similarity searches, etc.

   ```ruby
   def add_to_vector_database(texts)
     @vector_db_client.add_texts(texts: texts)
   end

   def similarity_search(query, k = 10)
     @vector_db_client.similarity_search(query: query, k: k)
   end
   ```

4. **Use in Rails Application**: Utilize these methods in your application for various functionalities.

5. **Error Handling**: Ensure robust error handling for vector database operations.

## Error Handling

The `OpenAiService` class includes basic error handling which will output the error message to the console. It is advisable to enhance the error handling based on your application's requirements.

## Customization

Feel free to customize the `OpenAiService` class based on your specific needs and the features provided by the `langchainrb` gem.

## Contributing

Contributions to improve the `OpenAiService` are welcome. Please adhere to the project's contributing guidelines.

## License

Specify the license under which the code is available, typically mirroring your Rails application's license.
