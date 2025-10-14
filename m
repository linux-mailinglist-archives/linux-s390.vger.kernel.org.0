Return-Path: <linux-s390+bounces-13889-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56778BD84FB
	for <lists+linux-s390@lfdr.de>; Tue, 14 Oct 2025 10:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DEB3ADCE4
	for <lists+linux-s390@lfdr.de>; Tue, 14 Oct 2025 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFA12877CB;
	Tue, 14 Oct 2025 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBoF7f5C"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033A2DF71C
	for <linux-s390@vger.kernel.org>; Tue, 14 Oct 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432190; cv=none; b=XMordyuZyc+0f9R6glBKvVuoxiSY1lGz6c8qmpsgJYwTUqY6HTJKsrTTWwVDOdhyqo3p509RgB/AsKoj6CbTKffVz1nbReO2fxsTeQ0rrAlOAnkzbsHgSrPPmdSsA++K5IQFVorO3y8DZ5EWqLZKoi7fQQ0+luGUczzFV1CTsn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432190; c=relaxed/simple;
	bh=Gx9Z6mn6RyElOVVuTuwoqX8a6quS8JbkEQ2dofakRLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oHJPjMkh/7DZGmhV/gufxF+2YyJLtueGuYnrMNucbaLlWLa+ahZM7x9pXoWBrytsYT+d1vdkcIkEHp/weR9Nrs2nAGc2WkRCYsr8dTk7+3ZKXYmcYtqtSrvxhUlNmZQdkyEytr4peTdLGb1+KpxuUyYe6uzEK5aW3FUUzF/N4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBoF7f5C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760432188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SzW2cWfpQXuLGQqbaNqxu1i17z4sh2RC+KzHuoIl4BY=;
	b=DBoF7f5CJLx8LIEZz8p61JrmQjd/o8kqXzoXDelIZykH9/2k+qSWOTHcXY1m2fAgPplnlj
	B+Yk1BjRGANpl92ORb4WnhFgnnk/4MKCpHnThWdJZ+342siCBJMd8/mzbgf8M/xEsli2fS
	TAYPsF0lHpiQr1OxWs1bPmjHgAyTLdw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-88ZyZhZiPSKzb3dgMZdLLQ-1; Tue,
 14 Oct 2025 04:56:22 -0400
X-MC-Unique: 88ZyZhZiPSKzb3dgMZdLLQ-1
X-Mimecast-MFC-AGG-ID: 88ZyZhZiPSKzb3dgMZdLLQ_1760432179
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A5F2180045C;
	Tue, 14 Oct 2025 08:56:17 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.33.199])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4B5F19560A2;
	Tue, 14 Oct 2025 08:56:08 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,  Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>,  Huacai Chen <chenhuacai@kernel.org>,
  WANG Xuerui <kernel@xen0n.name>,  Heiko Carstens <hca@linux.ibm.com>,
  Vasily Gorbik <gor@linux.ibm.com>,  Alexander Gordeev
 <agordeev@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>,  Thomas
 Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Borislav
 Petkov <bp@alien8.de>,  Dave Hansen <dave.hansen@linux.intel.com>,
  x86@kernel.org,  "H. Peter Anvin" <hpa@zytor.com>,  Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>,
  Johannes Berg <johannes@sipsolutions.net>,  Vincenzo Frascino
 <vincenzo.frascino@arm.com>,  Shuah Khan <shuah@kernel.org>,
  loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org,
  linux-s390@vger.kernel.org,  linux-um@lists.infradead.org,
  linux-api@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] vdso: Remove struct getcpu_cache
In-Reply-To: <CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
	(Andy Lutomirski's message of "Mon, 13 Oct 2025 10:14:58 -0700")
References: <20251013-getcpu_cache-v2-1-880fbfa3b7cc@linutronix.de>
	<e95dc212-6fd3-43e3-aeb7-bf55917e0cd4@intel.com>
	<CALCETrV2W3cZEJ2yy7F-F9=e_8HLP84ZWrOJCzUYn_ASb0+M6A@mail.gmail.com>
Date: Tue, 14 Oct 2025 10:56:06 +0200
Message-ID: <lhu5xchq2u1.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

* Andy Lutomirski:

> The theory is that people thought that getcpu was going to be kind of
> slow, so userspace would allocate a little cache (IIRC per-thread) and
> pass it in, and the vDSO would do, well, something clever to return
> the right value.  The something clever was probably based on the idea
> that you can't actually tell (in general) if the return value from
> getcpu is stale, since you might well get migrated right as the
> function returns anyway, so the cache could be something silly like
> (jiffies, cpu).

It probably had to do something with per-CPU or per-node mappings of the
vDSO.  Or may some non-coherent cache line in the vDSO.  As far as I
understand it, the cache has zero chance of working with the way vDSO
data is currently implemented.

We have the CPU ID and node ID in the restartable sequences area now
(although glibc does not use the node ID yet).  It's not a cache.  So
this clearly supersedes whatever struct getcpu_cache tried to achieve.

Thanks,
Florian


