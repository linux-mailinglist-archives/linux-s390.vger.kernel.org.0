Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B854C24F3E8
	for <lists+linux-s390@lfdr.de>; Mon, 24 Aug 2020 10:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgHXI0C (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 24 Aug 2020 04:26:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37338 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXI0B (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Aug 2020 04:26:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id s14so3873290plp.4;
        Mon, 24 Aug 2020 01:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Wap/ZTc4pJaZKu3+z+buHQ0KyRqlVzGqBFYKArIt/MWuVPPQFr2Wt+CMvqOgAmAtH8
         09qcNXI57T+NmQUjqzgpdHH+4cx85iDT+vQqQNrqJQEKNwqC0GdD2J+VDwLQ6zeNYlzD
         Gr9aPNaR2z3HqgMzbY0DyLHYwnqGW4X40EvDdJAd1Xpef/+PChmGtNAMWjXo1bzSUlK8
         qUHiMv/zWAkuJSTudJ2oyfHNjHenkejG2asPr2umQzpLd72gJLieozd1ZRS813Qj4PAk
         Vh7F+R5UJM8n1+g5Nzu10fd3MqIBRuibsauDWkht2rmpgd64iWnPqqwHc6guGQiD1ur4
         GYsg==
X-Gm-Message-State: AOAM531kRC52JILH3PXBC0GN43GtOGG6Ze77fapspXaiaOTnQHVRYpHY
        1s+CsoYmzenLCguE8Qd1Bms=
X-Google-Smtp-Source: ABdhPJxW0Sb1W31ji1xD5/tXnfUfq/0hDyEu38/TERhsoxJVdj23q3MPeALuQr+JGwJy3gfWJGZhFA==
X-Received: by 2002:a17:902:748c:: with SMTP id h12mr3050709pll.316.1598257560600;
        Mon, 24 Aug 2020 01:26:00 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:cda6:bf68:c972:645d? ([2601:647:4802:9070:cda6:bf68:c972:645d])
        by smtp.gmail.com with ESMTPSA id j5sm10776991pfg.80.2020.08.24.01.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 01:26:00 -0700 (PDT)
Subject: Re: [PATCH 1/3] block: replace bd_set_size with bd_set_nr_sectors
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Justin Sanders <justin@coraid.com>,
        linux-nvme@lists.infradead.org, Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Stefan Haberland <sth@linux.ibm.com>,
        nbd@other.debian.org, Hannes Reinecke <hare@suse.de>
References: <20200823091043.2600261-1-hch@lst.de>
 <20200823091043.2600261-2-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f31bb1a9-2f2c-2002-c7ce-29aa43feeafb@grimberg.me>
Date:   Mon, 24 Aug 2020 01:25:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823091043.2600261-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
