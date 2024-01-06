class ApplicationController < ActionController::Base
  include PublicKeyPinning, HttpClientHints
  include BlockSearchEngineIndexing
  include SetCurrentRequestDetails

  include SetVariant
  include ProceedToLocation

  include RequireAccount
  include Authenticate
  include ApiRequest
  include ForgeryProtection

  include RetryJBuilderErrors
  include ErrorResponses
  include SendExceptionToSentry

  include ETagForCurrentPerson
  include ETagForCurrentEnvironment
  include AssetFreshness, AssetReferences
  include FragmentCachingByAccount
  include ChromelessLayout
  include TurbolinksCacheControl

  include Anchoring

  include Appearances

  include ExcludeFromRecentHistory

  include Permissions
end
