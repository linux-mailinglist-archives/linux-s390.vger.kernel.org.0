Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D9423F27F
	for <lists+linux-s390@lfdr.de>; Fri,  7 Aug 2020 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgHGSI3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 7 Aug 2020 14:08:29 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41649 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgHGSI3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 7 Aug 2020 14:08:29 -0400
X-Greylist: delayed 556 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2020 14:08:27 EDT
Received: from [192.168.1.100] (unknown [195.24.90.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id AEA50D02B;
        Fri,  7 Aug 2020 20:59:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1596823150; bh=01HxtO8TjyfJb6k7J+gRA2TnNfEUBHAPhEjgIcuz/u0=;
        h=Subject:To:Cc:From:Date:From;
        b=TZTULKRv65g757g49+c8p7aM+O5iyuEpRaLPDmBHhSkHxNabM2L5i5kHksE2vJpS+
         tJGzy8V3xpxuF3TVXvPFqiwuM8QwRu2+YDUKV3ldo/yWku8Aop2iTuAkw88XBkrE34
         lNVudBFm8xuuiGNDqah5SHeuCyubS+/bZL3d19dgPUxcp+APNEE0rZ+FtMUPLNvfUJ
         4m+VQeWLF57npkWczWZ6nl0+Tyh/ETqCEZQABIGJsqiTOSox47SZsbLmH/YRAk6IcL
         h0/d4nZMkSGeNEaQEX8qTeZ5Hn7ZEzoK9lVUllrDIKvkx5wy0g87CDC9no5PWqz3WW
         zobGk1feb4Juw==
Subject: Re: [PATCH 21/22] crypto: qce - add check for xts input length equal
 to zero
To:     Andrei Botila <andrei.botila@oss.nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-s390@vger.kernel.org, Andrei Botila <andrei.botila@nxp.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@axis.com, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com>
 <20200807162010.18979-22-andrei.botila@oss.nxp.com>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <ecf46ef2-3ef5-7ce1-ebd7-09774df67a47@mm-sol.com>
Date:   Fri, 7 Aug 2020 20:59:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807162010.18979-22-andrei.botila@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

Thanks for the patch!

On 8/7/20 7:20 PM, Andrei Botila wrote:
> From: Andrei Botila <andrei.botila@nxp.com>
> 
> Standardize the way input lengths equal to 0 are handled in all skcipher
> algorithms. All the algorithms return 0 for input lengths equal to zero.
> 
> Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
> ---
>  drivers/crypto/qce/skcipher.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Stanimir Varbanov <svarbanov@mm-sol.com>

> 
> diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
> index 5630c5addd28..887fd4dc9b43 100644
> --- a/drivers/crypto/qce/skcipher.c
> +++ b/drivers/crypto/qce/skcipher.c
> @@ -223,6 +223,9 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
>  	int keylen;
>  	int ret;
>  
> +	if (!req->cryptlen && IS_XTS(rctx->flags))
> +		return 0;
> +
>  	rctx->flags = tmpl->alg_flags;
>  	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
>  	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
> 

-- 
regards,
Stan
