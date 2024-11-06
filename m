Return-Path: <linux-s390+bounces-6957-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139389BD9AB
	for <lists+linux-s390@lfdr.de>; Wed,  6 Nov 2024 00:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4FD1C22754
	for <lists+linux-s390@lfdr.de>; Tue,  5 Nov 2024 23:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9381D415B;
	Tue,  5 Nov 2024 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="E8y5BAMu"
X-Original-To: linux-s390@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7441D173F;
	Tue,  5 Nov 2024 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730849096; cv=none; b=VGy56EUSE2C3mmNYdOwEyRaZ+lsMeKDVSYjnDsu84eFnaBYpvYLUjYrhnoKwhZp9DPUfUOYqm+Q3uphedWYEwtWSiIfHTJvYTQPVRHHK20g0sLklIuUQy0nSDNxuYBcIZA3KQHeeTJHp3yA9PpbltKGLdI2REOuCnIomdmLTuJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730849096; c=relaxed/simple;
	bh=WBrXvisWGFVacpt8L8CR1Ghny5Os7cFYL38YkDzW2so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCED3/uaPWOb8oEGHBs9Ofjnwa2zbAdYTj2OtVWVgPR+S3myGo27VFXigBLfB5xZiQ1LK49oFdfuckstXRrTTaL+Ud8X3wo1OHYGOueOr8DHMhDUUsROiu/jVIvJ5iZMXdiYPj5r+xgv3Puq+Juw6wftSkYFkuISQcdjPmR1k3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=E8y5BAMu; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Z85oxaml3pFygeaU0fWuahQT3uC3szDBpioxh+fr6p8=; b=E8y5BAMu7l5T/j8C1tFJ1KDcFX
	mnJvUGB5DI0jKH8L9O2qhGGvueIxoeA/uvcXnXlu6RCcS2+bPPoQAhfpnhpWco5wlon65dlIyhTXc
	QxNDADTHpGMyKFaW0GAZuKPyDFGaGyecxAlIyAPNrJJ78uejUGTeunGzGO6GWEFg9Qi5NU1UjVp0B
	DRRnkFhaQG9WCPH5yPLC0BSPo89AuFc8O+Br5+oQklrFkCcjMHIpgJYnNfXgaUt4P43oFI8qJYoLC
	BKQiqND/sAEg7l4C0D1svuraFFHXHcpUKYMf/VIdjrf5jky/IbTJ+AnDIL4c9hc1BypJvPRN+9v+q
	GwxLZ0gw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t8Sui-00EkL5-2D;
	Wed, 06 Nov 2024 07:24:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 06 Nov 2024 07:24:44 +0800
Date: Wed, 6 Nov 2024 07:24:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, davem@davemloft.net, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 3/3] s390/crypto: New s390 specific shash phmac
Message-ID: <ZyqpPIGhg1qysXA-@gondor.apana.org.au>
References: <20241105135833.391957-1-freude@linux.ibm.com>
 <20241105135833.391957-4-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105135833.391957-4-freude@linux.ibm.com>

On Tue, Nov 05, 2024 at 02:58:32PM +0100, Harald Freudenberger wrote:
>
> +static inline int s390_phmac_sha2_setkey(struct crypto_shash *tfm,
> +					 const u8 *key, unsigned int keylen)
> +{
> +	struct s390_phmac_ctx *tfm_ctx = crypto_shash_ctx(tfm);
> +	int rc = -ENOMEM;
> +
> +	if (tfm_ctx->keylen) {
> +		kfree_sensitive(tfm_ctx->key);
> +		tfm_ctx->key = NULL;
> +		tfm_ctx->keylen = 0;
> +	}
> +
> +	tfm_ctx->key = kmemdup(key, keylen, GFP_KERNEL);

Please use GFP_ATOMIC.  GFP_KERNEL allocations are not allowed
in setkey.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

