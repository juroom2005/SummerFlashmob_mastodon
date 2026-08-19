# frozen_string_literal: true

module BrandingHelper
  # flashmob 커스텀:
  #   원본은 워드마크/아이콘을 <svg><use href="#symbol"> 로 그렸는데, 우리 로고
  #   SVG 는 내부에 gradient/pattern(url(#...)) 을 쓰기 때문에 <use> 로는 그
  #   참조가 깨져 안 그려진다. → 완결된 SVG 를 image_tag 로 직접 넣어 해결.
  #   (React logo.tsx 를 <img> 로 바꾼 것과 동일한 처리)
  #
  #   · 워드마크(:wordmark) = logo-full.svg (flashmob 가로 로고)
  #   · 아이콘(:icon)       = logo.svg      (정사각 심볼, 파랑 그라데)

  def logo_as_symbol(version = :icon)
    case version
    when :icon
      _logo_as_symbol_icon
    when :wordmark
      _logo_as_symbol_wordmark
    end
  end

  def _logo_as_symbol_wordmark
    image_tag(
      frontend_asset_path('images/logo-full.svg'),
      alt: 'Mastodon',
      class: 'logo logo--wordmark'
    )
  end

  def _logo_as_symbol_icon
    image_tag(
      frontend_asset_path('images/logo.svg'),
      alt: 'Mastodon',
      class: 'logo logo--icon'
    )
  end

  # 설정·관리자·리다이렉트 등 페이지 좌상단 로고.
  # SUMMER Flash Mob 풀로고(PNG)로 표시.
  def render_logo
    image_tag(
      frontend_asset_path('images/logo-flashmob-full.png'),
      alt: 'Mastodon',
      class: 'logo logo--full'
    )
  end
end