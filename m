Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88E890D0D
	for <lists+linux-s390@lfdr.de>; Sat, 17 Aug 2019 07:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbfHQFNW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 17 Aug 2019 01:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:55568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfHQFNW (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 17 Aug 2019 01:13:22 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D9DA2133F;
        Sat, 17 Aug 2019 05:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566018800;
        bh=kZh/mBQKvBcCKVRcP4EwaxzK6sS4usQe5ZFCButursw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LW4xRrhQIFVOT24Fgp2vrKGf2kebp4b3LBSiU/MLAWsYLp5zIeScwbGm6krOqoyqA
         pJeC9gs6BA4hnoomq7x1Zrw1Rf2tTKlm9Ub+8zQ6ck4+uYmFx83ccjiKiBpxCJG9T9
         mpMHw1z55iBZwBiiNSU4DR200QwxuVHUKn6xUslo=
Date:   Fri, 16 Aug 2019 22:13:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] crypto: sha256_generic - Use sha256_transform from
 generic sha256 lib
Message-ID: <20190817051318.GA8209@sol.localdomain>
Mail-Followup-To: Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190816211611.2568-1-hdegoede@redhat.com>
 <20190816211611.2568-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816211611.2568-7-hdegoede@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 16, 2019 at 11:16:11PM +0200, Hans de Goede wrote:
> Drop the duplicate sha256_transform function from crypto/sha256_generic.c
> and use the implementation from lib/crypto/sha256.c instead.
> "diff -u lib/crypto/sha256.c sha256_generic.c"
> shows that both implementations are identical.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Hi Hans, thanks for doing this!

I'm a little concerned that the only sha256 lib function which sha256_generic.c
calls is sha256_transform().  This means that sha256_init(), sha256_update(),
and sha256_final() are not tested by the crypto self-tests.  They could be
broken and we wouldn't know.

IMO, it would be better to make sha256_generic.c use sha256_init(),
sha256_update(), and sha256_final() rather than using sha256_base.h.
Then we'd get test coverage of both the sha256 lib, and of sha256_base.h
via the architecture-specific implementations.

To do this you'll also need to add sha224_init(), sha224_update(), and
sha224_final().  But that's straightforward.

- Eric
