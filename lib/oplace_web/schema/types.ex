defmodule OplaceWeb.Schema.Types do
  use Absinthe.Schema.Notation

  object :service do
    field :id, :id
    field :title, :string
    field :description, :string
    field :icon_url, :string
    field :is_active, :boolean
    field :inserted_at, :string
  end

  object :job_offer do
    field :id, :id
    field :title, :string
    field :description, :string
    field :short_description, :string
    field :status, :string
    field :contract_type, :string
    field :job_type, :string
    field :location, :string
    field :deadline, :string
    field :experience_level, :string
    field :image_url, :string
    field :views, :integer
    field :service_category, :string
    field :inserted_at, :string
  end

  object :job_submission do
    field :id, :id
    field :job_offer_id, :id
    field :job_title, :string
    field :first_name, :string
    field :last_name, :string
    field :phone, :string
    field :email, :string
    field :motivation, :string
    field :cv_url, :string
    field :status, :string
    field :inserted_at, :string
  end

  object :blog_article do
    field :id, :id
    field :title, :string
    field :slug, :string
    field :content, :string
    field :excerpt, :string
    field :image_url, :string
    field :video_url, :string
    field :audio_url, :string
    field :external_link, :string
    field :status, :string
    field :tags, list_of(:string)
    field :inserted_at, :string
  end

  object :partner do
    field :id, :id
    field :name, :string
    field :logo_url, :string
    field :website_url, :string
    field :is_active, :boolean
  end

  object :delete_result do
    field :success, :boolean
    field :message, :string
  end

  object :service_queries do
    field :services, list_of(:service) do
      resolve fn _, _, _ -> {:ok, Oplace.Services.list_services()} end
    end

    field :active_services, list_of(:service) do
      resolve fn _, _, _ -> {:ok, Oplace.Services.list_active_services()} end
    end

    field :service, :service do
      arg :id, non_null(:id)
      resolve fn %{id: id}, _ -> {:ok, Oplace.Services.get_service!(id)} end
    end
  end

  object :job_queries do
    field :job_offers, list_of(:job_offer) do
      resolve fn _, _, _ -> {:ok, Oplace.Jobs.list_job_offers()} end
    end

    field :active_jobs, list_of(:job_offer) do
      resolve fn _, _, _ -> {:ok, Oplace.Jobs.list_active_jobs()} end
    end

    field :job_offer, :job_offer do
      arg :id, non_null(:id)
      resolve fn %{id: id}, _ -> {:ok, Oplace.Jobs.get_job_offer!(id)} end
    end

    field :job_submissions, list_of(:job_submission) do
      resolve fn _, _, _ -> {:ok, Oplace.Jobs.list_submissions()} end
    end
  end

  object :blog_queries do
    field :articles, list_of(:blog_article) do
      resolve fn _, _, _ -> {:ok, Oplace.Blog.list_articles()} end
    end

    field :published_articles, list_of(:blog_article) do
      resolve fn _, _, _ -> {:ok, Oplace.Blog.list_published()} end
    end

    field :article, :blog_article do
      arg :slug, non_null(:string)
      resolve fn %{slug: slug}, _ -> {:ok, Oplace.Blog.get_article_by_slug!(slug)} end
    end
  end

  object :partner_queries do
    field :partners, list_of(:partner) do
      resolve fn _, _, _ -> {:ok, Oplace.Partners.list_partners()} end
    end
  end
end
