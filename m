Return-Path: <linux-s390+bounces-21262-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y/NkBueRPmrMIAkAu9opvQ
	(envelope-from <linux-s390+bounces-21262-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 26 Jun 2026 16:51:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C53DF6CE244
	for <lists+linux-s390@lfdr.de>; Fri, 26 Jun 2026 16:51:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=xBmLvvo9;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21262-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21262-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0928030765A7
	for <lists+linux-s390@lfdr.de>; Fri, 26 Jun 2026 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19640312F;
	Fri, 26 Jun 2026 14:46:06 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2E4400DFC
	for <linux-s390@vger.kernel.org>; Fri, 26 Jun 2026 14:45:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782485166; cv=none; b=cENiMunF3J+b84IBcLyRu+tusBoTdMIXjP5Ll6/BmGzDxzMaasJ/jyQzrmZf5sx83QvpCKIH5/tZYcf/x1d4BXulyRJSP10jyJWCn2B260TqZUivYbCXAsKREj4Ra1mVLBbeEMDXRN016Sbg18jete0z/egYmtoj+5YK5UzvJaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782485166; c=relaxed/simple;
	bh=BgssH8vCKDppnzbwBoJeH2HdO6TiCS4MwxNCxIwOGxg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dkJajmv3Ru1jQ31iWmKyMFkGvzJ0QI+nvTH9MrjilcLuxE4WVRemjBt/tNOblPcqGtJOr8GFFjBcZ9qwaTd0u2hGok+nZ0vB36t+ZwNVhlMQtY+piiD2x2tZHBKOeb8Qad7ROauiTtG5B28J8Ri/nOctk1FYG/sxYo3GX9rsn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xBmLvvo9; arc=none smtp.client-ip=91.218.175.177
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782485154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLoe9hgpuLGAv9HcjQXiuki+Z1Eo9W05Z+080Efe+Rc=;
	b=xBmLvvo9VeLWl6aCPOHJfACC84T1J3BTjH51kQr8iuIJvUHkpL0TY/1jmfKt3pAIas6Dh6
	hMKA2it5f7Povtcv7HNEPaX/tbq52whxslXQwIYDMnFdkUFHHwDlaTZMjI6N1SUuxeL0dB
	Mk0ZoJAcKfnjrWev0iaDEvycix+RYjk=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 14:45:45 +0000
Message-Id: <DJJ28Z81JTQI.1SI0CNIP7W1JQ@linux.dev>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
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
 "corbet@lwn.net" <corbet@lwn.net>, "oupton@kernel.org" <oupton@kernel.org>,
 "joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com"
 <suzuki.poulose@arm.com>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
 <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
 "tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
 "peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org"
 <willy@infradead.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>,
 "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
 <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org"
 <song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
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
 <yosry@kernel.org>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>, "tabba@google.com"
 <tabba@google.com>, "prsampat@amd.com" <prsampat@amd.com>,
 "wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com"
 <jmattson@google.com>, "jthoughton@google.com" <jthoughton@google.com>,
 "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "alex@ghiti.fr"
 <alex@ghiti.fr>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "chenhuacai@kernel.org" <chenhuacai@kernel.org>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "dev.jain@arm.com" <dev.jain@arm.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org"
 <pjw@kernel.org>, "shijie@os.amperecomputing.com"
 <shijie@os.amperecomputing.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>,
 "lenb@kernel.org" <lenb@kernel.org>, "pavel@kernel.org" <pavel@kernel.org>,
 "yangyicong@hisilicon.com" <yangyicong@hisilicon.com>,
 "vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
 <jackmanb@google.com>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>,
 "Itazuri, Takahiro" <itazur@amazon.co.uk>
Subject: Re: [PATCH v12 09/16] KVM: arm64: define
 kvm_arch_gmem_supports_no_direct_map()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Marc Zyngier" <maz@kernel.org>, "Kalyazin, Nikita"
 <kalyazin@amazon.co.uk>
References: <20260410151746.61150-1-kalyazin@amazon.com>
 <20260410151746.61150-10-kalyazin@amazon.com>
 <86fr4o1ceu.wl-maz@kernel.org>
In-Reply-To: <86fr4o1ceu.wl-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21262-lists,linux-s390=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kvm@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel@xen0n.name,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:loongarch@lists.linux.dev,m:linux-pm@vger.kernel.org,m:pbonzini@redhat.com,m:corbet@lwn.net,m:oupton@kernel.org,m:joey.gouly@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:seanjc@google.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:luto@kernel.org,m:peterz@infradead.org,m:willy@infradead.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:lorenzo.stoakes@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org
 ,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:kpsingh@kernel.org,m:sdf@fomichev.me,m:haoluo@google.com,m:jolsa@kernel.org,m:jgg@ziepe.ca,m:jhubbard@nvidia.com,m:peterx@redhat.com,m:jannh@google.com,m:pfalcato@suse.de,m:skhan@linuxfoundation.org,m:riel@surriel.com,m:ryan.roberts@arm.com,m:jgross@suse.com,m:yu-cheng.yu@intel.com,m:kas@kernel.org,m:coxu@redhat.com,m:ackerleytng@google.com,m:yosry@kernel.org,m:ajones@ventanamicro.com,m:maobibo@loongson.cn,m:tabba@google.com,m:prsampat@amd.com,m:wu.fei9@sanechips.com.cn,m:mlevitsk@redhat.com,m:jmattson@google.com,m:jthoughton@google.com,m:agordeev@linux.ibm.com,m:alex@ghiti.fr,m:borntraeger@linux.ibm.com,m:chenhuacai@kernel.org,m:baolu.lu@linux.intel.com,m:dev.jain@arm.com,m:palmer@dabbelt.com,m:pjw@kernel.org,m:shijie@os.amperecomputing.com,m:thuth@redhat.com,m:yang@os.amperecomputing.com,m:Liam.Howlett@oracle.com,m:zhengqi.arch@bytedance.com,m:lenb@kernel.org,m:pave
 l@kernel.org,m:yangyicong@hisilicon.com,m:vannapurve@google.com,m:jackmanb@google.com,m:patrick.roy@linux.dev,m:itazur@amazon.co.uk,m:maz@kernel.org,m:kalyazin@amazon.co.uk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[brendan.jackman@linux.dev,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,kvack.org,xen0n.name,redhat.com,lwn.net,kernel.org,arm.com,huawei.com,google.com,alien8.de,linux.intel.com,zytor.com,infradead.org,linux-foundation.org,oracle.com,suse.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,ziepe.ca,nvidia.com,suse.de,linuxfoundation.org,surriel.com,intel.com,ventanamicro.com,loongson.cn,amd.com,sanechips.com.cn,linux.ibm.com,ghiti.fr,dabbelt.com,os.amperecomputing.com,bytedance.com,hisilicon.com,amazon.co.uk];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[95];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brendan.jackman@linux.dev,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,vger.kernel.org:from_smtp,amazon.co.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C53DF6CE244

On Tue Apr 21, 2026 at 4:55 PM UTC, Marc Zyngier wrote:
> On Fri, 10 Apr 2026 16:19:24 +0100,
> "Kalyazin, Nikita" <kalyazin@amazon.co.uk> wrote:
>>=20
>> From: Patrick Roy <patrick.roy@linux.dev>
>>=20
>> Support for GUEST_MEMFD_FLAG_NO_DIRECT_MAP on arm64 depends on 1) direct
>> map manipulations at 4k granularity being possible, and 2) FEAT_S2FWB.
>>=20
>> 1) is met whenever the direct map is set up at 4k granularity (e.g. not
>>  with huge/gigantic pages) at boottime, as due to ARM's
>> break-before-make semantics, breaking huge mappings into 4k mappings in
>> the direct map is not possible (BBM would require temporary invalidation
>> of the entire huge mapping, even if only a 4k subrange should be zapped,
>> which will probably crash the kernel). However, the current default for
>> rodata_full is true, which forces a 4k direct map.
>
> Where is this 4kB requirement enforced? Or is it that you means
> "PAGE_SIZE"?

Yeah I believe this means PAGE_SIZE and that it's effectively enforced
by checking can_set_direct_map() in
kvm_arch_gmem_supports_no_direct_map().

