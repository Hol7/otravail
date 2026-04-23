defmodule OplaceWeb.Schema.Mutations do
  use Absinthe.Schema.Notation

  object :service_mutations do
    field :create_service, :service do
      arg :title, non_null(:string)
      arg :description, :string
      arg :icon_url, :string
      arg :is_active, :boolean
      resolve fn args, _ ->
        case Oplace.Services.create_service(args) do
          {:ok, service} -> {:ok, service}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :update_service, :service do
      arg :id, non_null(:id)
      arg :title, :string
      arg :description, :string
      arg :icon_url, :string
      arg :is_active, :boolean
      resolve fn %{id: id} = args, _ ->
        service = Oplace.Services.get_service!(id)
        case Oplace.Services.update_service(service, Map.delete(args, :id)) do
          {:ok, s} -> {:ok, s}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :delete_service, :delete_result do
      arg :id, non_null(:id)
      resolve fn %{id: id}, _ ->
        service = Oplace.Services.get_service!(id)
        case Oplace.Services.delete_service(service) do
          {:ok, _} -> {:ok, %{success: true, message: "Deleted"}}
          {:error, _} -> {:ok, %{success: false, message: "Error"}}
        end
      end
    end
  end

  object :job_mutations do
    field :create_job_offer, :job_offer do
      arg :title, non_null(:string)
      arg :description, :string
      arg :short_description, :string
      arg :status, :string
      arg :contract_type, :string
      arg :job_type, :string
      arg :location, :string
      arg :deadline, :string
      arg :experience_level, :string
      arg :image_url, :string
      arg :service_category, :string
      resolve fn args, _ ->
        case Oplace.Jobs.create_job_offer(args) do
          {:ok, j} -> {:ok, j}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :update_job_offer, :job_offer do
      arg :id, non_null(:id)
      arg :title, :string
      arg :status, :string
      arg :contract_type, :string
      arg :location, :string
      arg :deadline, :string
      resolve fn %{id: id} = args, _ ->
        job = Oplace.Jobs.get_job_offer!(id)
        case Oplace.Jobs.update_job_offer(job, Map.delete(args, :id)) do
          {:ok, j} -> {:ok, j}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :increment_job_views, :job_offer do
      arg :id, non_null(:id)
      resolve fn %{id: id}, _ ->
        job = Oplace.Jobs.get_job_offer!(id)
        case Oplace.Jobs.increment_views(job) do
          {:ok, j} -> {:ok, j}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :delete_job_offer, :delete_result do
      arg :id, non_null(:id)
      resolve fn %{id: id}, _ ->
        job = Oplace.Jobs.get_job_offer!(id)
        case Oplace.Jobs.delete_job_offer(job) do
          {:ok, _} -> {:ok, %{success: true, message: "Deleted"}}
          {:error, _} -> {:ok, %{success: false, message: "Error"}}
        end
      end
    end
  end

  object :submission_mutations do
    field :create_submission, :job_submission do
      arg :job_offer_id, :id
      arg :job_title, :string
      arg :first_name, non_null(:string)
      arg :last_name, non_null(:string)
      arg :phone, non_null(:string)
      arg :email, :string
      arg :motivation, non_null(:string)
      arg :cv_url, :string
      resolve fn args, _ ->
        case Oplace.Jobs.create_submission(args) do
          {:ok, s} -> {:ok, s}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :update_submission_status, :job_submission do
      arg :id, non_null(:id)
      arg :status, non_null(:string)
      resolve fn %{id: id, status: status}, _ ->
        sub = Oplace.Jobs.get_submission!(id)
        case Oplace.Jobs.update_submission(sub, %{status: status}) do
          {:ok, s} -> {:ok, s}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end
  end

  object :blog_mutations do
    field :create_article, :blog_article do
      arg :title, non_null(:string)
      arg :slug, :string
      arg :content, :string
      arg :excerpt, :string
      arg :image_url, :string
      arg :status, :string
      arg :tags, list_of(:string)
      resolve fn args, _ ->
        case Oplace.Blog.create_article(args) do
          {:ok, a} -> {:ok, a}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :update_article, :blog_article do
      arg :id, non_null(:id)
      arg :title, :string
      arg :content, :string
      arg :status, :string
      arg :tags, list_of(:string)
      resolve fn %{id: id} = args, _ ->
        article = Oplace.Blog.get_article!(id)
        case Oplace.Blog.update_article(article, Map.delete(args, :id)) do
          {:ok, a} -> {:ok, a}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :delete_article, :delete_result do
      arg :id, non_null(:id)
      resolve fn %{id: id}, _ ->
        article = Oplace.Blog.get_article!(id)
        case Oplace.Blog.delete_article(article) do
          {:ok, _} -> {:ok, %{success: true, message: "Deleted"}}
          {:error, _} -> {:ok, %{success: false, message: "Error"}}
        end
      end
    end
  end

  object :partner_mutations do
    field :create_partner, :partner do
      arg :name, non_null(:string)
      arg :logo_url, :string
      arg :website_url, :string
      arg :is_active, :boolean
      resolve fn args, _ ->
        case Oplace.Partners.create_partner(args) do
          {:ok, p} -> {:ok, p}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :update_partner, :partner do
      arg :id, non_null(:id)
      arg :name, :string
      arg :logo_url, :string
      arg :website_url, :string
      arg :is_active, :boolean
      resolve fn %{id: id} = args, _ ->
        partner = Oplace.Partners.get_partner!(id)
        case Oplace.Partners.update_partner(partner, Map.delete(args, :id)) do
          {:ok, p} -> {:ok, p}
          {:error, cs} -> {:error, inspect(cs.errors)}
        end
      end
    end

    field :delete_partner, :delete_result do
      arg :id, non_null(:id)
      resolve fn %{id: id}, _ ->
        partner = Oplace.Partners.get_partner!(id)
        case Oplace.Partners.delete_partner(partner) do
          {:ok, _} -> {:ok, %{success: true, message: "Deleted"}}
          {:error, _} -> {:ok, %{success: false, message: "Error"}}
        end
      end
    end
  end
end
