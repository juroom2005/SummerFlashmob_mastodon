import classNames from 'classnames';

import logo from '@/images/logo.svg';
import logoFull from '@/images/logo-full.svg';

// flashmob 커스텀:
//   기존 WordmarkLogo/IconLogo 는 <use xlink:href="#symbol"> 로 심볼을 참조했는데,
//   우리 로고 SVG 는 내부에 gradient/pattern(url(#...)) 를 쓰기 때문에 <use> 로
//   복제될 때 그 참조가 shadow tree 경계를 못 넘어 안 그려졌다.
//   → 완결된 SVG 파일을 <img> 로 직접 넣어 문제를 원천 제거.
//   (SymbolLogo 가 원래 쓰던 <img> 방식과 동일. gradient/pattern 정상 렌더)

export const WordmarkLogo: React.FC = () => (
  <img src={logoFull} alt='Mastodon' className='logo logo--wordmark' />
);

export const IconLogo: React.FC<{ className?: string }> = ({ className }) => (
  <img
    src={logo}
    alt='Mastodon'
    className={classNames('logo logo--icon', className)}
  />
);

export const SymbolLogo: React.FC = () => (
  <img src={logo} alt='Mastodon' className='logo logo--icon' />
);
