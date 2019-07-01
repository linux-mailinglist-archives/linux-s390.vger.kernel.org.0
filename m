Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8455CE8
	for <lists+linux-s390@lfdr.de>; Wed, 26 Jun 2019 02:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFZA2m (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 25 Jun 2019 20:28:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45904 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFZA2m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 25 Jun 2019 20:28:42 -0400
Received: by mail-io1-f68.google.com with SMTP id e3so1080000ioc.12
        for <linux-s390@vger.kernel.org>; Tue, 25 Jun 2019 17:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/uR/4PciUq//wm8VvTrYpqXShwr7/kFFKyCPyP8pcs=;
        b=YeX/xFTe86cLjtEiwNDGr0CKTn6yvfRoFVYAyjGpJqcjyjOauh0oSms8qNpsPWv76x
         eRvUUgmWL0+6wScBbr8rD2ZZ/RfhNpAX4UKm1peplkD8GmwmOk+8uVKUsB9hanwxe3Dm
         H0krLG+sD5Fzr71HJU1x0kXlYQzuI9cWXt4LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/uR/4PciUq//wm8VvTrYpqXShwr7/kFFKyCPyP8pcs=;
        b=mrdGv1q0VBBDkpAfhVlrRbk8b1wi8/J6usgX15pkAUEdET/xrYTOZBXwBjlcRwQJ49
         R4dKRPlxKdPpJ+O1jIwpEJOAs1DpodfrvEYyKZDR/K5dPce4ZongROP04qTyeVg83oMW
         VkC8QX8glRJzqNbj4S95nbLKmT9E3bNvxmkHZ6Bo1BdVs2Kv1ZTPuT97i6Q5wwMqLAWu
         t/OpwmbHi7ewBzQl/f8Y6OOf6FlSSefN2Tstjjo2Ldx09mgpd+P+w+UTizz1vyQ+SH3e
         rbjiU38e5WlJkOResViJs8neawC1cp/0TLsGksByTnULEuSsX7HRlq/dQPHttCLe6gYQ
         RsMw==
X-Gm-Message-State: APjAAAUzz9QM+NXoq/qy4+f0xHDUJ+q+S3CNMdV1YF7hk7dU0ph6PxCW
        u+JynaV91nmZCp3ygzBh+QMDSYD+Rn6RGHlLnQc29g==
X-Google-Smtp-Source: APXvYqxX0Qrt909cJIALCW0svY89PQl3z7r/J2jSYrLO+BEo6+PoMkKF1jAWxKfLc2PBHctF8DPoeOKanHzXan7VOSY=
X-Received: by 2002:a6b:6d07:: with SMTP id a7mr1751422iod.254.1561508921439;
 Tue, 25 Jun 2019 17:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
In-Reply-To: <1561501810-25163-1-git-send-email-Hoan@os.amperecomputing.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Jun 2019 08:28:30 +0800
Message-ID: <CAADWXX8wdEPNZ26SFJUfwrhQson3HPTrZ7D2jju3RhEeMuc+QQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Enable CONFIG_NODES_SPAN_OTHER_NODES by default for NUMA
To:     Hoan Tran OS <hoan@os.amperecomputing.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "David S . Miller" <davem@davemloft.net>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Open Source Submission <patches@amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is not a comment on the patch series itself, it is a comment on the emails.

Your email is mis-configured and ends up all being marked as spam for
me, because you go through the wrong smtp server (or maybe your smtp
server itself is miconfigured)

All your emails fail dmarc, because the "From" header is
os.amperecomputing.com, but the DKIM signature is for
amperemail.onmicrosoft.com.

End result: it wil all go into the spam box of anybody who checks DKIM.

                       Linus

On Wed, Jun 26, 2019 at 6:30 AM Hoan Tran OS
<hoan@os.amperecomputing.com> wrote:
>
> This patch set enables CONFIG_NODES_SPAN_OTHER_NODES by default
> for NUMA. [...]
