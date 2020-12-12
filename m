Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C348D2D858E
	for <lists+linux-s390@lfdr.de>; Sat, 12 Dec 2020 11:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438531AbgLLKBj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 12 Dec 2020 05:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438539AbgLLKBc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 12 Dec 2020 05:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607767202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqytnWHmiXa+Di95y5cLkMPHeDA8E7hFbdSv3omYri8=;
        b=L39003LNmXKTl1ijqJxQxPcNgpWXoaX9EDNo58wTTZlKeJYLC9QfLkZujb+p0KhKD4AUnH
        eq01rjUUXy/5R8X7x1HwgxeXU2GQzvSqtV0JYQTmYGNEfs2QB/55AQHEWwzgnzG544bDiL
        A8uVrQDWYWp4EgR2YObILkFYlfXT5gg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-aW5Ct-jDM4-Qh-7qsvp-6A-1; Sat, 12 Dec 2020 03:58:35 -0500
X-MC-Unique: aW5Ct-jDM4-Qh-7qsvp-6A-1
Received: by mail-ed1-f71.google.com with SMTP id cq17so5180105edb.17
        for <linux-s390@vger.kernel.org>; Sat, 12 Dec 2020 00:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mqytnWHmiXa+Di95y5cLkMPHeDA8E7hFbdSv3omYri8=;
        b=BdEJpz61XHNaYaHl4bBwBuDhnftoRu9ZqqozUzb0eWmGTdOP8Vlf8scaClC0f1rnBx
         LY39nudO3lBHZt/90cK3TdvrmLot38qeLzMtCC6ks0N/4XnEOKi7nO9OwvMKEhacU+Zg
         kSkMzSojCSgcTJhaT/uGnEM0NAZKJw4P4DIdeG4pjP1LM9r8LbEnuk8AMSnM2T2VTPnl
         rCQt0D4JLf0Qwnc1lBuFU/5GZjpcp6/x4HKwmk46tka2wF5Ue4PEFSofOzsIS2beNpp8
         i3/heni89UDn02gOfOD00NOk6a/y7mfxV2L3ncZEO5DWei6n9Y/oATr27Qf3zeOX53bb
         9Q9A==
X-Gm-Message-State: AOAM530MN/dSCV1rgBdir3oJ6jpME35c7oe3SSFR90sKRxMogi1FyLk6
        xXlJewy+MqZQmMLLHU/O1vOSRHxRS+m3kzq5kCSVycyKE8WphFFbrM1xcHmRb0tZlZgh8dISBRP
        WB54btFr2ImNNVsHJirFiJg==
X-Received: by 2002:a17:906:e093:: with SMTP id gh19mr14499738ejb.510.1607763513784;
        Sat, 12 Dec 2020 00:58:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjcC4qLFJDONn4gSe2O+WmHUA/dQM7eXyyXAesmAunOsoTEsz2yxGYrRGFW809kDTB3U6Shw==
X-Received: by 2002:a17:906:e093:: with SMTP id gh19mr14499723ejb.510.1607763513586;
        Sat, 12 Dec 2020 00:58:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j2sm8628980eja.97.2020.12.12.00.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 00:58:32 -0800 (PST)
Subject: Re: [GIT PULL 0/4] KVM: s390: features and test for 5.11
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Collin Walling <walling@linux.ibm.com>
References: <20201210142600.6771-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <43278089-2579-8a3d-8f13-81b8d3b75836@redhat.com>
Date:   Sat, 12 Dec 2020 09:58:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201210142600.6771-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/12/20 15:25, Christian Borntraeger wrote:
> Paolo,
> 
> the following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:
> 
>    Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.11-1
> 
> for you to fetch changes up to 50a05be484cb70d9dfb55fa5a6ed57eab193901f:
> 
>    KVM: s390: track synchronous pfault events in kvm_stat (2020-12-10 14:20:26 +0100)
> 
> ----------------------------------------------------------------
> KVM: s390: Features and Test for 5.11
> 
> - memcg accouting for s390 specific parts of kvm and gmap
> - selftest for diag318
> - new kvm_stat for when async_pf falls back to sync
> 
> The selftest even triggers a non-critical bug that is unrelated
> to diag318, fix will follow later.
> 
> ----------------------------------------------------------------
> Christian Borntraeger (3):
>        KVM: s390: Add memcg accounting to KVM allocations
>        s390/gmap: make gmap memcg aware
>        KVM: s390: track synchronous pfault events in kvm_stat
> 
> Collin Walling (1):
>        KVM: selftests: sync_regs test for diag318
> 
>   arch/s390/include/asm/kvm_host.h                   |  1 +
>   arch/s390/kvm/guestdbg.c                           |  8 +--
>   arch/s390/kvm/intercept.c                          |  2 +-
>   arch/s390/kvm/interrupt.c                          | 10 +--
>   arch/s390/kvm/kvm-s390.c                           | 22 +++---
>   arch/s390/kvm/priv.c                               |  4 +-
>   arch/s390/kvm/pv.c                                 |  6 +-
>   arch/s390/kvm/vsie.c                               |  4 +-
>   arch/s390/mm/gmap.c                                | 30 ++++----
>   tools/testing/selftests/kvm/Makefile               |  2 +-
>   .../kvm/include/s390x/diag318_test_handler.h       | 13 ++++
>   .../selftests/kvm/lib/s390x/diag318_test_handler.c | 82 ++++++++++++++++++++++
>   tools/testing/selftests/kvm/s390x/sync_regs_test.c | 16 ++++-
>   13 files changed, 156 insertions(+), 44 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/include/s390x/diag318_test_handler.h
>   create mode 100644 tools/testing/selftests/kvm/lib/s390x/diag318_test_handler.c
> 

Pulled, thanks.

Paolo

