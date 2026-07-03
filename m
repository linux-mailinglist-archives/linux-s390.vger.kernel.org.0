Return-Path: <linux-s390+bounces-21555-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jqcNJkfNR2oifgAAu9opvQ
	(envelope-from <linux-s390+bounces-21555-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 16:55:03 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28123703A27
	for <lists+linux-s390@lfdr.de>; Fri, 03 Jul 2026 16:55:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=GoqgUdNe;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21555-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21555-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8623D3001FFC
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jul 2026 14:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7373F484B;
	Fri,  3 Jul 2026 14:55:00 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C82367D3
	for <linux-s390@vger.kernel.org>; Fri,  3 Jul 2026 14:54:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090500; cv=none; b=pljVZhFFZI7ljcq6GnLlkiWujrsuPpaU3kqt0Ag4r4osNpeu2JHD4fcCpgrNQko9b7mgBrDu9cAiOYYro+tjv/9BzIeHIpfTZssMvRCKqfBW50xU0Vb1MO7unGbhzJzxd5Ku483kiogAp8XvHHLYayVQQGIoghLNGjQ3rUa/paI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090500; c=relaxed/simple;
	bh=SbPuoxe9/8K5nDiss1P1G+SXa5cD6+BbCbutJ10O3gA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aEYthiScmjqUuGUIQI+318CQxUtDxTTcAFgbC+J4x8PUqD6uNMIxTYDBLdMq86jsEp9eM/fNRnAayQaOqQCyuv4ExydXTXYUTErHXCL4DAr0DYfn3HNss2mjuOsPkGH8zMYah6KzDcRnm3JULODtBG92sSzFErp3BPf86w9b/5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GoqgUdNe; arc=none smtp.client-ip=91.218.175.179
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783090495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbPuoxe9/8K5nDiss1P1G+SXa5cD6+BbCbutJ10O3gA=;
	b=GoqgUdNey9WibpT4bCWElWCK/Q8ZarEulgJnOwtH8yUYJA68i9+SGQflaQqhfntmLTLqoe
	eB23ClEBpn2xCd2QuZuRlpe/F6BVVRjYG8MpJKtoXNNPTsnfkNo24Jc6bEsuCimTjf2nDr
	Gtk6mCa7gTMDQeIwZl5Jn3GGSudvZ6Y=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 14:54:45 +0000
Message-Id: <DJP0TON6OW7J.EPYIYFFA5ZOZ@linux.dev>
Cc: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
 <kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
 <linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
 <linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
 <loongarch@lists.linux.dev>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "suzuki.poulose@arm.com"
 <suzuki.poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "will@kernel.org" <will@kernel.org>, "seanjc@google.com"
 <seanjc@google.com>, "tglx@kernel.org" <tglx@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org"
 <david@kernel.org>, "lorenzo.stoakes@oracle.com"
 <lorenzo.stoakes@oracle.com>, "vbabka@kernel.org" <vbabka@kernel.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
 <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
 "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
 <kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
 <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
 <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jannh@google.com" <jannh@google.com>, "pfalcato@suse.de"
 <pfalcato@suse.de>, "skhan@linuxfoundation.org"
 <skhan@linuxfoundation.org>, "riel@surriel.com" <riel@surriel.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com"
 <jgross@suse.com>, "yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>,
 "kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>, "yosry@kernel.org"
 <yosry@kernel.org>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "tabba@google.com" <tabba@google.com>, "prsampat@amd.com"
 <prsampat@amd.com>, "jthoughton@google.com" <jthoughton@google.com>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "aou@eecs.berkeley.edu"
 <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
 <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org"
 <chenhuacai@kernel.org>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "dev.jain@arm.com" <dev.jain@arm.com>,
 "gor@linux.ibm.com" <gor@linux.ibm.com>, "hca@linux.ibm.com"
 <hca@linux.ibm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "pjw@kernel.org" <pjw@kernel.org>, "shijie@os.amperecomputing.com"
 <shijie@os.amperecomputing.com>, "svens@linux.ibm.com"
 <svens@linux.ibm.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com"
 <urezki@gmail.com>, "zhengqi.arch@bytedance.com"
 <zhengqi.arch@bytedance.com>, "gerald.schaefer@linux.ibm.com"
 <gerald.schaefer@linux.ibm.com>, "jiayuan.chen@shopee.com"
 <jiayuan.chen@shopee.com>, "rafael@kernel.org" <rafael@kernel.org>,
 "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
 "vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
 <jackmanb@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>,
 "Itazuri, Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek"
 <derekmn@amazon.com>
Subject: Re: [PATCH v12 02/16] set_memory: add
 folio_{zap,restore}_direct_map helpers
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Mike Rapoport" <rppt@kernel.org>, "Brendan Jackman"
 <brendan.jackman@linux.dev>
References: <20260410151746.61150-1-kalyazin@amazon.com>
 <20260410151746.61150-3-kalyazin@amazon.com>
 <DJOUYOKL6N3R.BFIO8HEL03OA@linux.dev> <ake7aPB2O_-dAXhI@kernel.org>
In-Reply-To: <ake7aPB2O_-dAXhI@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21555-lists,linux-s390=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kalyazin@amazon.co.uk,m:kvm@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel@xen0n.name,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-pm@vger.kernel.org,m:pbonzini@redhat.com,m:corbet@lwn.net,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:will@kernel.org,m:seanjc@google.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:luto@kernel.org,m:peterz@infradead.org,m:willy@infradead.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:lorenzo.stoakes@oracle.com,m:vbabka@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:ast@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend
 @gmail.com,m:kpsingh@kernel.org,m:sdf@fomichev.me,m:haoluo@google.com,m:jolsa@kernel.org,m:jgg@ziepe.ca,m:jhubbard@nvidia.com,m:peterx@redhat.com,m:jannh@google.com,m:pfalcato@suse.de,m:skhan@linuxfoundation.org,m:riel@surriel.com,m:ryan.roberts@arm.com,m:jgross@suse.com,m:yu-cheng.yu@intel.com,m:kas@kernel.org,m:coxu@redhat.com,m:ackerleytng@google.com,m:yosry@kernel.org,m:maobibo@loongson.cn,m:tabba@google.com,m:prsampat@amd.com,m:jthoughton@google.com,m:agordeev@linux.ibm.com,m:aou@eecs.berkeley.edu,m:borntraeger@linux.ibm.com,m:chenhuacai@kernel.org,m:baolu.lu@linux.intel.com,m:dev.jain@arm.com,m:gor@linux.ibm.com,m:hca@linux.ibm.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:shijie@os.amperecomputing.com,m:svens@linux.ibm.com,m:thuth@redhat.com,m:yang@os.amperecomputing.com,m:Liam.Howlett@oracle.com,m:urezki@gmail.com,m:zhengqi.arch@bytedance.com,m:gerald.schaefer@linux.ibm.com,m:jiayuan.chen@shopee.com,m:rafael@kernel.org,m:yangyicong@hisilicon.com,m:vannapurve@google.com,m:jackm
 anb@google.com,m:patrick.roy@linux.dev,m:itazur@amazon.co.uk,m:derekmn@amazon.com,m:rppt@kernel.org,m:brendan.jackman@linux.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[brendan.jackman@linux.dev,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[amazon.co.uk,vger.kernel.org,lists.infradead.org,lists.linux.dev,kvack.org,xen0n.name,redhat.com,lwn.net,arm.com,huawei.com,kernel.org,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.com,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,linuxfoundation.org,surriel.com,intel.com,loongson.cn,amd.com,linux.ibm.com,eecs.berkeley.edu,dabbelt.com,os.amperecomputing.com,bytedance.com,shopee.com,hisilicon.com,amazon.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[92];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brendan.jackman@linux.dev,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28123703A27

On Fri Jul 3, 2026 at 1:38 PM UTC, Mike Rapoport wrote:
> On Fri, Jul 03, 2026 at 10:19:10AM +0000, Brendan Jackman wrote:
...
>> Alternatively, we maybe should disable secretmem for highmem systems
>> since it evidently doesn't have any users.
>
> Yes, please :)=20

https://lore.kernel.org/all/20260703-secretmem-highmem-v1-1-30d5ff944664@go=
ogle.com/

