Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B88100568
	for <lists+linux-s390@lfdr.de>; Mon, 18 Nov 2019 13:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKRMPX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Nov 2019 07:15:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54408 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726614AbfKRMPX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Nov 2019 07:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574079322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=Tvff9PjqKA3FC9Q4ynPdaw5FsHpxecBMvggOiUz4ut8=;
        b=efbGKIUmTl0asb3DDMoKVuBweU8iJpOPfbh91ob2rWkoSnYa2qZ3X2NuJJNDQueiTHio4V
        ErJ0RP+7bgrGun21Gx5qA7/TKWGS+3XLqqtZFvEvwdLM1QY6aVH4Ou53Tz4mphmmZ9fCvI
        88CcSnaUYMFDuGtEjP+8CaOzBEOpuo0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-Ts-WKJFWMGmy_EQ-X1bQpQ-1; Mon, 18 Nov 2019 07:15:18 -0500
Received: by mail-wm1-f69.google.com with SMTP id z3so11251936wmk.1
        for <linux-s390@vger.kernel.org>; Mon, 18 Nov 2019 04:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xs0m8LNfKnUXtv8PJqCMeNUP3E1GcGcsQ1R88aG03k8=;
        b=mwZ/D8to+VbMBZx/bFlOSDYgxZO95bfxsav31iAtPxRzWF9q1WSNTTJV6Xjp66ieBe
         IukQIE3WrtgX9Y0yoyg/tFm3SM34pQzWKEP4VTNIAr687ems8b224tlIIpi1ZJuIERRV
         wyIeNhKh9prq9coeIWOxglzh64Vx4TkJ1VWW2I+/ro7wizhEmkuYL8jOROJzwkV5TT/6
         HrSjlioX/pwoJWPJ7T5yfAWIsCRYZsIGHHD40GAc/zsxeaVfPZJaqYzKEJLpPvirfwNZ
         LXqg3775d3ZZuqD1XKaK/onySwDKUh+FULazknPfSs+NvDhJjnJE34jh/wcmdDJPRCaW
         cqVQ==
X-Gm-Message-State: APjAAAXxrtpuaKnWZL0M8heDH7ki/w608tcsotP5t3ArkuGRsOw56rcz
        Bseykul5w68MJT1l6i2QhOSw8kuZNWbACqaRld7NCmuRgmbmDVj88stACmAmA8Y7E4sIOBaqnxu
        Ym2kAtlbGyElocXwBakWJoA==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr14143044wrs.288.1574079317026;
        Mon, 18 Nov 2019 04:15:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7HhhvDpKdnMV3luY7p/3OqKwDpVpkL0j68I32euep6688sfJZoDUoYCS30LQeY+ysUrl6xQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr14143005wrs.288.1574079316717;
        Mon, 18 Nov 2019 04:15:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc? ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
        by smtp.gmail.com with ESMTPSA id j67sm21255526wmb.43.2019.11.18.04.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 04:15:16 -0800 (PST)
Subject: Re: [GIT PULL 0/5] KVM: s390: fixes and enhancements for 5.5
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
References: <20191118083602.15835-1-borntraeger@de.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <47e79931-f6e0-ad92-e705-0d6c07cdf515@redhat.com>
Date:   Mon, 18 Nov 2019 13:15:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191118083602.15835-1-borntraeger@de.ibm.com>
Content-Language: en-US
X-MC-Unique: Ts-WKJFWMGmy_EQ-X1bQpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/11/19 09:35, Christian Borntraeger wrote:
> Paolo, Radim,
>=20
> everybody is busy on the ultravisor related things, so only a small
> number of changes for s390 for 5.5.
>=20
> The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c=
5c:
>=20
>   Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-next-5.5-1
>=20
> for you to fetch changes up to c7b7de63124645089ccf9900b9e5ea08059ccae0:
>=20
>   KVM: s390: Do not yield when target is already running (2019-10-10 13:1=
8:40 +0200)
>=20

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: small fixes and enhancements
>=20
> - selftest improvements
> - yield improvements
> - cleanups
>=20
> ----------------------------------------------------------------
> Christian Borntraeger (3):
>       selftests: kvm: make syncregs more reliable on s390
>       KVM: s390: count invalid yields
>       KVM: s390: Do not yield when target is already running
>=20
> Janosch Frank (1):
>       KVM: s390: Cleanup kvm_arch_init error path
>=20
> Thomas Huth (1):
>       KVM: s390: Remove unused parameter from __inject_sigp_restart()
>=20
>  arch/s390/include/asm/kvm_host.h                   |  1 +
>  arch/s390/kvm/diag.c                               | 22 ++++++++++++++++=
++----
>  arch/s390/kvm/interrupt.c                          |  5 ++---
>  arch/s390/kvm/kvm-s390.c                           | 19 ++++++++--------=
---
>  tools/testing/selftests/kvm/s390x/sync_regs_test.c | 15 +++++++++------
>  5 files changed, 38 insertions(+), 24 deletions(-)
>=20

