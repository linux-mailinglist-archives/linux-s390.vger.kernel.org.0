Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED68B20A636
	for <lists+linux-s390@lfdr.de>; Thu, 25 Jun 2020 21:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436497AbgFYTzK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 25 Jun 2020 15:55:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406888AbgFYTzC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 25 Jun 2020 15:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593114901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMmWD42emjWTjisxH2mhg8ooA/tzTNuz83b0inCszAo=;
        b=OOTJEsFiHL7qFTS9sWbEAwCUvg2YoaBg1eN+exgSZdJfJk+aoK1O/BUQHo5k1I6h1FerxR
        1YMMZ4Z5Ti+H148Ff4jafpo5wbZmfHFQzhrfEO25cikE+grG/ahGVAIrTkS6zNjzp9jK8J
        02EVR/9Av0gzKQT0craREic5LDwFBJw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-v6Vt08SbNlm9wus8jjgPAA-1; Thu, 25 Jun 2020 15:54:59 -0400
X-MC-Unique: v6Vt08SbNlm9wus8jjgPAA-1
Received: by mail-ed1-f72.google.com with SMTP id c1so5905100edd.21
        for <linux-s390@vger.kernel.org>; Thu, 25 Jun 2020 12:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=wMmWD42emjWTjisxH2mhg8ooA/tzTNuz83b0inCszAo=;
        b=U9bpJMcr8qUmpq4HruZ3uTihvt7/CegjILj365uTIzg4uVWr8znjYTZNCpeWdot8pe
         NdXmHkAALcVx/tTLEW22XXRmAIp1iX6O2UMf2+HidIrgLkCTstLAYRhU+W4eQZpcTiyA
         dc1X62jaMbqs97NsAefCpuBgPmRGWFJKcUQJ1bgQj41vyNYpeg9MIWre1cR+G//uIyFR
         UlXAOyrS4iubbUIc16P0bSaI3tC8/2jUyuSRupBOPIWTQ6qESis/K1a90h/GkMdRi4ZW
         uUzttA/vurP4yHR6gSAss9L27LhqEv6fw4eymTtdwkZqO8g7tk0y1riFsbLArjvG4msy
         m7BQ==
X-Gm-Message-State: AOAM530lJOQ6n1vTO+IMsjOe3d0uz4Dr87WP7Czd9C6Igelz1wIllmU3
        40moiUBu0ceVulBEswGSRt4QI9QUcmItpuFPYX3hyj1Dzjeze58KlxkVuHlifikvIZu0J69l7VX
        ORrQ1wy8HOqtlqfB0ZQD6tQ==
X-Received: by 2002:a17:906:81d2:: with SMTP id e18mr3825024ejx.341.1593114898271;
        Thu, 25 Jun 2020 12:54:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5E/w1rTnVuKXZNENv7G0eGJhbp6+G0E9LkJ3uLdKtkufHLsXOdh6ZMYC+QQ77kfhoMtI4gw==
X-Received: by 2002:a17:906:81d2:: with SMTP id e18mr3825008ejx.341.1593114898113;
        Thu, 25 Jun 2020 12:54:58 -0700 (PDT)
Received: from [192.168.3.122] (p4ff23f47.dip0.t-ipconnect.de. [79.242.63.71])
        by smtp.gmail.com with ESMTPSA id d12sm12947661edx.80.2020.06.25.12.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 12:54:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] s390x/vmem: get rid of memory segment list
Date:   Thu, 25 Jun 2020 21:54:56 +0200
Message-Id: <93B4CEE2-3C8D-481F-89BC-09C931866201@redhat.com>
References: <20200625193837.GA5050@osiris>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
In-Reply-To: <20200625193837.GA5050@osiris>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> Am 25.06.2020 um 21:38 schrieb Heiko Carstens <heiko.carstens@de.ibm.com>:=

>=20
> =EF=BB=BFOn Thu, Jun 25, 2020 at 05:00:29PM +0200, David Hildenbrand wrote=
:
>> This smells like a leftover from ancient times, let's get rid of it. We
>> can now convert vmem_remove_mapping() into a void function - everybody
>> ignored the return value already.
>=20
> This buys us what? Except that we get rid of a bit of code?

I=E2=80=98m looking into virtio-mem support for s390x, including vmemmap/vme=
m optimizations. Virtio-mem adds/removes memory in memory block granularity,=
 which results in one list entry for essentially each memory section. That s=
eems to be easy to avoid.

Thanks=

