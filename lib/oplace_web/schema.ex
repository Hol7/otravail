defmodule OplaceWeb.Schema do
  use Absinthe.Schema

  import_types OplaceWeb.Schema.Types
  import_types OplaceWeb.Schema.Mutations

  query do
    import_fields :service_queries
    import_fields :job_queries
    import_fields :blog_queries
    import_fields :partner_queries
  end

  mutation do
    import_fields :service_mutations
    import_fields :job_mutations
    import_fields :submission_mutations
    import_fields :blog_mutations
    import_fields :partner_mutations
  end
end
