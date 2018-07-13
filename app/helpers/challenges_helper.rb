module ChallengesHelper
  def sanitizeHtml(html)
    sanitize html, tags: %w(strong)
  end
end
