Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740F62B689C
	for <lists+linux-s390@lfdr.de>; Tue, 17 Nov 2020 16:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbgKQPXJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 17 Nov 2020 10:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729288AbgKQPXI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 10:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605626588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SJ3uhZ5yltOc5xnB64Kwt8PJdWNSrNtUsMWUat0LdzE=;
        b=jI6HwNUlOaBcxbWbAv7jFMy2P4rt8cPSFmHsQYrGcE+2TSbjSSiLTdgZNp2m52ny7UmOx8
        xBCfy3gbrn4PyyIFWEM4jeJSlhUqgVNmjQPUY9xgAfm4LTNCUiV3jxv0SQt0KlWy+hC3cW
        EduKlN6Kl7qyc3ivaKYMHH31DRGs+E8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-8ovlM493Owiuu2nI88qksQ-1; Tue, 17 Nov 2020 10:23:06 -0500
X-MC-Unique: 8ovlM493Owiuu2nI88qksQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F47D91E075;
        Tue, 17 Nov 2020 15:23:05 +0000 (UTC)
Received: from [10.36.114.99] (ovpn-114-99.ams2.redhat.com [10.36.114.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E8F919930;
        Tue, 17 Nov 2020 15:23:04 +0000 (UTC)
Subject: Re: [PATCH 0/2] KVM: s390: memcg awareness
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <20201117151023.424575-1-borntraeger@de.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d22fb5b1-af1e-3970-c4cc-b38f93d0d6e5@redhat.com>
Date:   Tue, 17 Nov 2020 16:23:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201117151023.424575-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17.11.20 16:10, Christian Borntraeger wrote:
> This got somehow lost.  (so this is kind of a v2)
> KVM does have memcg awareness. Lets implement this also for s390kvm
> and gmap.

Looks sane to me.


-- 
Thanks,

David / dhildenb

