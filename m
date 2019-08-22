Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1FC98B0A
	for <lists+linux-s390@lfdr.de>; Thu, 22 Aug 2019 07:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731520AbfHVF5T (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 22 Aug 2019 01:57:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58420 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730851AbfHVF5T (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 22 Aug 2019 01:57:19 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1i0g5w-0002ze-8y; Thu, 22 Aug 2019 15:57:12 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1i0g5w-00012x-1l; Thu, 22 Aug 2019 15:57:12 +1000
Date:   Thu, 22 Aug 2019 15:57:12 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] crypto: s390/xts-aes - invoke fallback for ciphertext
 stealing
Message-ID: <20190822055711.GG3860@gondor.apana.org.au>
References: <20190816123545.22848-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816123545.22848-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 16, 2019 at 03:35:45PM +0300, Ard Biesheuvel wrote:
> For correctness and compliance with the XTS-AES specification, we are
> adding support for ciphertext stealing to XTS implementations, even
> though no use cases are known that will be enabled by this.
> 
> Since the s390 implementation already has a fallback skcipher standby
> for other purposes, let's use it for this purpose as well. If ciphertext
> stealing use cases ever become a bottleneck, we can always revisit this.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/s390/crypto/aes_s390.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
