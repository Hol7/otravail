defmodule Oplace.Jobs do
  import Ecto.Query
  alias Oplace.Repo
  alias Oplace.Jobs.{JobOffer, JobSubmission}

  def list_job_offers, do: Repo.all(from j in JobOffer, order_by: [desc: j.inserted_at])
  def list_active_jobs, do: Repo.all(from j in JobOffer, where: j.status == "active", order_by: [desc: j.inserted_at])
  def get_job_offer!(id), do: Repo.get!(JobOffer, id)

  def increment_views(%JobOffer{} = job) do
    job |> JobOffer.changeset(%{views: job.views + 1}) |> Repo.update()
  end

  def create_job_offer(attrs), do: %JobOffer{} |> JobOffer.changeset(attrs) |> Repo.insert()
  def update_job_offer(%JobOffer{} = j, attrs), do: j |> JobOffer.changeset(attrs) |> Repo.update()
  def delete_job_offer(%JobOffer{} = j), do: Repo.delete(j)

  def list_submissions, do: Repo.all(from s in JobSubmission, order_by: [desc: s.inserted_at], preload: [:job_offer])
  def list_submissions_for_job(job_id), do: Repo.all(from s in JobSubmission, where: s.job_offer_id == ^job_id)
  def get_submission!(id), do: Repo.get!(JobSubmission, id)
  def create_submission(attrs), do: %JobSubmission{} |> JobSubmission.changeset(attrs) |> Repo.insert()
  def update_submission(%JobSubmission{} = s, attrs), do: s |> JobSubmission.changeset(attrs) |> Repo.update()
  def delete_submission(%JobSubmission{} = s), do: Repo.delete(s)
end
