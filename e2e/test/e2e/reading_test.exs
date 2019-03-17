defmodule E2e.ReadingTest do
    use ExUnit.Case 

    @test_dir "test/res"

    setup do 
        create_test_dir()
        on_exit fn -> 
            kill()
            remove_test_dir()
        end
    end

    test "workflow from creating project up to displaying articles and single article" do 
        

        create_category("category 1")
        create_category("category 2")

        create_article("article 1", "category 1")
        create_article("article 2", "category 1")
        create_article("article 3", "category 1")
        create_article("article 4", "category 2")
        create_article("article 5", "category 2")
        
        start()
        :timer.sleep(10000);

        {:ok, homepage} = HTTPoison.get("http://localhost:4000")
        assert homepage.body =~ "images/landmap" 
        assert homepage.status_code == 200

        {:ok, articles} = HTTPoison.get("http://localhost:4000/articles")
        assert articles.status_code == 200
        assert articles.body =~ "article 1"
        assert articles.body =~ "article 2"
        assert articles.body =~ "article 3"
        assert articles.body =~ "article 4"
        assert articles.body =~ "article 5"

        # navigate to homepage
        # navigate to articles and check links
        # follow links to articles and check their content
        
    end

    def start() do 
        File.write("#{Path.expand(@test_dir)}/run_app.sh", """
            export ARTICLE_PATH=#{Path.expand(@test_dir)}
            cd ../../../web_viewer
            ./scripts/build.sh
            ./scripts/prod_run.sh
            """)
        System.cmd("chmod", ["+x", "run_app.sh"], cd: Path.expand(@test_dir))
        Task.async fn -> System.cmd("sh", ["./run_app.sh"], cd: Path.expand(@test_dir)) end 
    end

    def kill() do 
        System.cmd("sh", ["./kill.sh"], cd: Path.expand("test/e2e"))
    end

    defp create_article(title, category) do 
        create_article(title, category, title)
    end

    defp create_article(title, category, content) do 
        File.write("#{@test_dir}/#{category}/#{title}.md", """
        #{title}
        ========

        |info  |               |
        |------|---------------|
        |date  |01.01.2019     |
        |author|Thomas Deniffel|
        |key 1 | val 1         |
        |tags  |tag1,tag2      |

        #{content}
        """)
    end

    defp create_test_dir() do 
        File.mkdir("#{@test_dir}")
    end

    defp create_category(category) do 
        File.mkdir("#{@test_dir}/#{category}")
    end

    defp remove_test_dir() do 
        File.rm_rf(@test_dir)
    end
  

end