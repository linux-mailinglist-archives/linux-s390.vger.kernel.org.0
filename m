Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97B1B6CDAD
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jul 2019 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGRLvT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 18 Jul 2019 07:51:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:59324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbfGRLvT (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 07:51:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 73AFDAF78;
        Thu, 18 Jul 2019 11:51:17 +0000 (UTC)
Date:   Thu, 18 Jul 2019 13:51:12 +0200
From:   Petr Tesarik <ptesarik@suse.cz>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Is __dma_direct_alloc_pages broken on s390?
Message-ID: <20190718135112.5c65685f@ezekiel.suse.cz>
In-Reply-To: <20190718113633.GB3581@osiris>
References: <20190718091700.353b3721@ezekiel.suse.cz>
        <20190718113633.GB3581@osiris>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v_n94xccOBLow5SYZVroKI9"; protocol="application/pgp-signature"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--Sig_/v_n94xccOBLow5SYZVroKI9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jul 2019 13:36:33 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Thu, Jul 18, 2019 at 09:17:00AM +0200, Petr Tesarik wrote:
> > Hi all,
> >=20
> > while looking into DMA allocation, I noticed that
> > __dma_direct_optimal_gfp_mask() in kernel/dma/direct.c can probably be
> > improved. It uses GFP_DMA if dev->coherent_dma_mask is less than
> > DMA_BIT_MASK(ARCH_ZONE_DMA_BITS). There is no s390-specific definition
> > of ARCH_ZONE_DMA_BITS. The default is 24 bits, but the DMA zone on s390
> > is 31 bits. CCW subchannel devices set sch->dev.coherent_dma_mask to
> > DMA_BIT_MASK(31), which is greater than DMA_BIT_MASK(24), so buffers
> > are allocated from the Normal zone first.
> >=20
> > Would it make sense to set ARCH_ZONE_BITS to 31 on s390, or did I miss
> > something? =20
>=20
> No, this seems to be broken. Halil, can you look into this and provide
> a patch?

I wondered why the kernel works OK on my system, and it is in fact not
so bad. If the first allocation fails, the kernel adds GFP_DMA and
retries, so this is not fatal, but with a proper definition of
ARCH_ZONE_DMA_BITS it should be possible to get success in the first
attempt already, let's do it.

Petr T

--Sig_/v_n94xccOBLow5SYZVroKI9
Content-Type: application/pgp-signature
Content-Description: Digitální podpis OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEHl2YIZkIo5VO2MxYqlA7ya4PR6cFAl0wXTAACgkQqlA7ya4P
R6ekCwgAi42D6YRMVH8crfml27a7/nevbvMHDDsU9yl+p+57LEQ646TKY8SP5lF1
lSsGKtXwWYgeZBdYevD/ttUVg54+fZi4LAZaIRNKuUTwqFub0yY7qEP2UEPA+FAl
gKeGoY/VKWUc8G8kZSe44PbNjSk9Kobf/EBDft1V7fW0G3QDX4nhhQ/Lne38a/wc
2EtwlCEYvTFe4e1vCgmVfu3I8jKwHOxQ8gJ9mWqvBDpiNtITAsEenKTlKbK9o24K
yPD/9NY+UyhuQmflacbhBPMXSxIQYQxbcQ1vJ3+4K1sB15it1SQsnsWy1Oyng2v7
591MxHqjPsA4qX53O2ai+2JhojsmuQ==
=hES4
-----END PGP SIGNATURE-----

--Sig_/v_n94xccOBLow5SYZVroKI9--
