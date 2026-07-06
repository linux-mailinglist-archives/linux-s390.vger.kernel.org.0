Return-Path: <linux-s390+bounces-21665-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nuSYDUsQTGonfwEAu9opvQ
	(envelope-from <linux-s390+bounces-21665-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 22:30:03 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CDA715703
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 22:30:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ziepe.ca header.s=google header.b=fqbZjHym;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21665-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21665-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 925A33087121
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 19:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB333C9EF3;
	Mon,  6 Jul 2026 19:53:17 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2643451AF
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 19:53:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367597; cv=none; b=qOKRw82b+JevPLyoX1FJtOVtw80J3AEE8QP64slHFSLJpYV2pYreY5YyQaKd/jNGAZAwSR+wXaQ61Yrzf4DKK6l0DQL20HFFxuAFCEE/vIwvFBee2ZDsKcqmTkaKjgXEm8k1Laer3yH8WUDx0uANMZ7yaVDhkw7QJtCKp9z1Iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367597; c=relaxed/simple;
	bh=1B+jpjxTx5TOVbLZW+lRl8rr9j7yKX/HAr+WiXhXlbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WolfNFKJgTvbaPy/JWnu09lnrwl5aGrhkbrTxwx7Q0gDMjsB7OTn/VUP/ja3YMKmEXmVFob8KyKVsKzWRHXxrak0V4lB+H5vcZxabgVyb6cXGiQ4EJ0LcfjdPuWdfTvUW5kDE+6wHad/PMMHiwVy/lCTM8crryMgVssONie08go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fqbZjHym; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e5cb052edso253241385a.2
        for <linux-s390@vger.kernel.org>; Mon, 06 Jul 2026 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783367595; x=1783972395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ryDaMDdUIlJtmHnTUoGTHsXnTD+6T4wqV6GsP0/9lPI=;
        b=fqbZjHym0ifEhAZqRzgUDN/Gwk56hz29n09jTffE59OGWa2kTsodnVyIn3JK6mCb0s
         S/kLQIHkBT58ojGxLPzT6PWF4uao/yCBuxQPNMcclTzbGJT67hlXF3JYNTWEqpb71z7n
         KcbFPk9Q9woPFiyLGi1FJp+isp2MCmsJEa6Ud2X4ZU733E0q22ooio5uOfvJk6PHt7wb
         +XePMjE1892oSVlEO7gMsS2A3OsNnlwVxDC9Yh00r3dt8AoNZmjbRxiU3uNaYhrenYRC
         NJ5ufF3EfCgyHJLCWfpEnl68OPk2i3uqK4z/bm+53MnNtKYJxrJq5HGesawuoSnvjbHq
         VezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783367595; x=1783972395;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryDaMDdUIlJtmHnTUoGTHsXnTD+6T4wqV6GsP0/9lPI=;
        b=o006Y2aKn8lozWh8B2VYToD+izmaWuxZfGZYCZ1UN1OZuNlly+bp64U5UHounPDg2a
         wpPDvpQ2UGRoI3ydGs3QVS2fkNWUw0RX9ek0iMwpWwYMe+iW3l4W2Wea6n0/wetd90bC
         dc4wzG3Id2szGSdxBDQ4EAR98wV/SW9z+zBb6n63cUKlsbxEoxqZOB16P/XwhsNVoeQj
         6d9QNo6qRFVrDvfNlhoa9ARoqygMRCXxSlZNPokcEKl1QC/WUYCx53QllvTI6nJhIezK
         gN02UflwuxO7EU4q8mM6MoFQwTWbMV5ycEOnX42ZxI64E2mam/t/MgO8vouDZD+DKYU9
         5EgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrsy3P1DdMxRgVvTKE6l3QkJy9y1i+GMWe5aUcvUeyvLCRSIsP4SkMMvV/0SM+GOea6wRoy0pheQXhm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu/nBaooVbvFs0lgPifp+Ptzxh1D9Atvirhe9BQxJ3GV3+/m48
	xo/+oNvge8SCb7L55tuHk5XcZxfhCD10ftG7Sli5cZJ+L6yR3EaxNkWUfNBtovusibI=
X-Gm-Gg: AfdE7clLC8NtsQ7doMNfFT0nRIbgZnP6okRKrlZH1xHbhugywMEXASBT6S05YNE990e
	M1vuEMvFmpI/KEX8yCd+1AMS/EE4esOKV6Deao9Msc7Al6bYNCY/wGOeIeeRmZwlngKp5ULEaRW
	MY67aZKARFyGXAji9mm16IiTl/QJ96/X2jtTJHe3X7YQYtWQuFNDV7JESaU+fTSN6Gl4ANc1haG
	FMAAzoMZ0B3+DaiUbfW0dNS5Mu0gfs/kIXiz9ZKl3r8T8s/DL2JwMtPsC2TDMx/P0GTHtxmOHrV
	W7h3QbhdXv6MvUE3TU4LY4c7miyftCqRqHR5y83mBvqmyC+HNOh77Ac5LaddDBf0mM3O9CrpJrl
	3OXFl+rUt/TJuCWlIoBS/4pUlZ198Rps0gaS1nA+FicCxM+penQiMU9Z5+CNn
X-Received: by 2002:a05:620a:1791:b0:92e:4773:5a05 with SMTP id af79cd13be357-92ebb52f990mr273301285a.4.1783367594962;
        Mon, 06 Jul 2026 12:53:14 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90cce037sm988196785a.38.2026.07.06.12.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:53:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wgpNR-00000000euT-3bF7;
	Mon, 06 Jul 2026 16:53:13 -0300
Date: Mon, 6 Jul 2026 16:53:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
	Nico Boehr <nrb@linux.ibm.com>,
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 01/27] VFIO: take reference to the KVM module
Message-ID: <20260706195313.GE118978@ziepe.ca>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-2-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706085229.979525-2-seiden@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21665-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:kvm@vger.kernel.org,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gra@linux.ibm.com,m:arnd@arndb.de,m:catalin.marinas@arm.com,m:borntraeger@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:fritz@linux.ibm.com,m:ggala@linux.ibm.com,m:hari55@linux.ibm.com,m:hca@linux.ibm.com,m:brueckner@linux.ibm.com,m:iii@linux.ibm.com,m:frankja@linux.ibm.com,m:joey.gouly@arm.com,m:maz@kernel.org,m:nrb@linux.ibm.com,m:oss@nina.schoetterlglausch.eu,m:oupton@kernel.org,m:pbonzini@redhat.com,m:suzuki.poulose@arm.com,m:svens@linux.ibm.com,m:Ulrich.Weigand@de.ibm.com,m:gor@linux.ibm.com,m:will@kernel.org,m:yuzenghui@huawei.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:from_mime,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76CDA715703

On Mon, Jul 06, 2026 at 10:52:01AM +0200, Steffen Eiden wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> VFIO is implicitly taking a reference to the KVM module between
> vfio_device_get_kvm_safe and vfio_device_put_kvm, thanks to
> symbol_get and symbol_put.

I thought we weren't doing this approach? Use the struct file as the
kvm handle. I thought I saw patches doing that already?

Jason

