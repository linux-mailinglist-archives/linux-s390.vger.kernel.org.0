Return-Path: <linux-s390+bounces-13527-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7C4B9597B
	for <lists+linux-s390@lfdr.de>; Tue, 23 Sep 2025 13:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00EC12E53ED
	for <lists+linux-s390@lfdr.de>; Tue, 23 Sep 2025 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E954932128E;
	Tue, 23 Sep 2025 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddC9IAXp"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B72321430
	for <linux-s390@vger.kernel.org>; Tue, 23 Sep 2025 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626070; cv=none; b=n/9sC0kicFTBH0IlsRYym2UVWHkAIrZXkh6Hh3eN6gT4sGvtEtYvN3uXb5hJbFYLtpHhzJdpmT5PZyEvS5MZtB6X4VZYR2HiOWIOSKBkblUtG57Zuv6tJj7Q4KfMV7CcQMO6rmnDq3L/bDPnaBx1yy2rc5spJ57HMbZM3Gbkezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626070; c=relaxed/simple;
	bh=Yp0jIbo0J4z4J89d67/4IYef1vaGUtevUrG+Br7P9/8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YMhkwvgt+qK5TSixi0XnE5KJbDieODHH4eY82cfDELOZCo4otKWFwCABK4O9x2L4Z9oghE28197Rna6LP5KQEY+umycModH+O8SlWqsIgZKHIAhV7gB7qJxo5fTGaWR0Te2uc0NXJ9mdz6X3xpT7dTIMPIdmrtN3cxPf93m2tr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddC9IAXp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758626068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OREkw1j/S6ldjKgAl+hzVyxqo9Gzj0q+cU0YJZ2A3rI=;
	b=ddC9IAXpxqbEYEc7r90sSWH9zH/MY9OxxiT/lmLjU4zHOiwBhgot9pslagiiASapqxxE8V
	ZNKCJHfEPiljzB6ViokU4kPH/67rsT/5VEFquFY77t9Q5GH5Ar0Fg0bg9XuhBpL+fvWHAn
	pgJY9pGwLaVc2qrmDNq/Gl6PUmvnviI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-qM3rh90KNf-Sh2aiTI9XcA-1; Tue,
 23 Sep 2025 07:14:23 -0400
X-MC-Unique: qM3rh90KNf-Sh2aiTI9XcA-1
X-Mimecast-MFC-AGG-ID: qM3rh90KNf-Sh2aiTI9XcA_1758626061
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE3391956096;
	Tue, 23 Sep 2025 11:14:20 +0000 (UTC)
Received: from [10.45.225.219] (unknown [10.45.225.219])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59AC7195608E;
	Tue, 23 Sep 2025 11:14:16 +0000 (UTC)
Date: Tue, 23 Sep 2025 13:14:10 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>, 
    Harald Freudenberger <freude@linux.ibm.com>, 
    Ingo Franzki <ifranzki@linux.ibm.com>, linux-crypto@vger.kernel.org, 
    Eric Biggers <ebiggers@kernel.org>, dengler@linux.ibm.com, 
    linux-s390@vger.kernel.org, dm-devel@lists.linux.dev, agk@redhat.com, 
    snitzer@kernel.org, Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH] crypto/authenc: don't return -EBUSY when enqueuing the
 hash request
In-Reply-To: <aNIYTm6neC3lC6dP@gondor.apana.org.au>
Message-ID: <194f9d1e-b6b0-54c7-6eb8-37ac0c0c1f9d@redhat.com>
References: <20250908131642.385445532@debian4.vm> <3a6b6f8f-5205-459c-810a-2425aae92fc8@linux.ibm.com> <e1e420d5-dc00-14d0-fdef-635d6ef70811@redhat.com> <bb68f9d6-8180-4291-9e6b-33bbdcef780f@linux.ibm.com> <8cb59ed5-1c9a-49de-beee-01eda52ad618@linux.ibm.com>
 <1af710ec-0f23-2522-d715-e683b9e557d8@redhat.com> <f799d7ab97470f2529b8dcb5566fd673@linux.ibm.com> <e26aedc6-7132-46c3-78f3-a3582b1c4f9a@redhat.com> <aNIYTm6neC3lC6dP@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On Tue, 23 Sep 2025, Herbert Xu wrote:

> If authenc gets EBUSY from the ahash, then the ahash is responsible
> for sending an EINPROGRESS notification.  I just checked the authenc
> code and it does pass the notification back up to the caller (which
> is dm-crypt).
> 
> So if EINPROGRESS is not being received, then it's a bug in the
> ahash layer or the underlying ahash algorithm.

static void authenc_request_complete(struct aead_request *req, int err)
{
        if (err != -EINPROGRESS)
                aead_request_complete(req, err);
}

This prevents -EINPROGRESS from reaching dm-crypt. If I remove the 
condition "err != -EINPROGRESS", the deadlock goes away. Though, removing 
it may break other things - we may send -EINPROGRESS twice, first for the 
hash and then for the decryption.

> Which phmac implementation was this?

It was pseudo_phmac out-of-tree module sent by Harald Freudenberger. He 
CC'd you, so you should have it as an attachment in your inbox.

The following scripts creates the buggy device mapper device:

#!/bin/sh -ex
sync
modprobe crypto_engine
insmod ~/c/phmac/pseudo_phmac/phmac.ko
modprobe brd rd_size=1048576
dmsetup create cr_dif --table '0 2031880 integrity 1:0 32768 32 J 7 block_size:4096 interleave_sectors:32768 buffer_sectors:128 journal_sectors:16368 journal_watermark:50 commit_time:10000 fix_padding'
dmsetup create cr --table '0 2031880 crypt capi:authenc(phmac(sha256),xts(aes))-plain64 00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 0 252:0 0 2 integrity:32:aead sector_size:4096'
dd if=/dev/zero of=/dev/mapper/cr bs=1M oflag=direct status=progress

> Cheers,

Mikulas


